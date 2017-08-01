module AASM
  module Generators
    module OrmHelpers

      def model_contents
        if column_name == 'aasm_state'
<<RUBY
  include AASM

  aasm do
  end
RUBY
        else
<<RUBY
  include AASM

  aasm :column => '#{column_name}' do
  end
RUBY
        end
      end

      private

      def model_exists?
        File.exists?(File.join(destination_root, model_path))
      end

      def model_path
        @model_path ||= File.join("app", "models", "#{file_path}.rb")
      end

      def state_change_log_table_exists?
        File.exists?(File.join(destination_root, state_change_log_migration_path))
      end

      def state_change_log_migration_path
        "db/migrate/create_aasm_state_change_logs.rb"
      end

    end
  end
end
