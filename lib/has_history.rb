module HasHistory

  module ClassMethods
    def has_history(name=:histories, options={})
      base_namespace = self.to_s.split('::')[0..-2].join('::')
      base_namespace = 'Object' if base_namespace == ''
      base_name = self.to_s.split('::')[-1] + 'History'
      unless eval("defined?(#{self.to_s}History)") && eval("#{self.to_s}History.is_a?(Class)")
        eval("#{base_namespace}.const_set(base_name, create_tmp_class)")
        self.has_many(name, :class_name => base_name, foreign_key: :item_id)

        options[:create] = true if options[:create] == nil
        options[:destroy] = true if options[:destroy] == nil
        options[:update] = true if options[:update] == nil

        options.each do |key, value|
          if value
            eval("self.around_#{key} :around_#{key}_his")
          end
        end

        self.send(:include, InstanceMethods)
        self.send :class_variable_set, '@@tmp_his_attr', name
        self.cattr_accessor :tmp_his_attr
      end
    end

    def create_tmp_class
      Class.new(Common::OperationHistory)
    end
  end

  module InstanceMethods

    def respond_to?(method, pri=false)
      (method.to_s =~ /^around_( \ w+) _his $/) || super
    end

    def method_missing(sym, *args)
      if sym.to_s =~ /^around_(\w+)_his$/
        flag = self.changed? && defined?(session)
        diff = self.changes
        yield
        return unless flag
        pattern = $1
        attr_name = self.tmp_his_attr
        hisArr = instance_eval(attr_name.to_s)
        hisArr.build(:user_id => session[:user_id], :item_id => self.id, :op_type => pattern, :detail => diff.to_s).save
      else
        super
      end
    end
  end
end

ActiveRecord::Base.send(:extend, HasHistory::ClassMethods)
