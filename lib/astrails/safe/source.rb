module Astrails
  module Safe
    class Source < Stream

      attr_accessor :id
      def initialize(id, config)
        @id, @config = id.to_s, config
      end

      def timestamp
        Time.now.strftime("%Y%m%d-%H%M")
      end

      def kind
        self.class.human_name
      end

      def filename
        #@filename ||= expand(":kind-:id.:timestamp")
        #@filename ||= expand(":id.:timestamp")
        @filename ||= expand(":timestamp-:id")
      end

      def backup
        return @backup if @backup
        @backup = Backup.new(
          :id        => @id,
          :kind      => kind,
          :extension => extension,
          :command   => command,
          :timestamp => timestamp
        )
        # can't do this in the initializer hash above since
        # filename() calls expand() which requires @backup
        # FIXME: move expansion to the backup (last step in ctor) assign :tags here
        @backup.filename = filename
        @backup
      end

      protected

      def self.human_name
        name.split('::').last.downcase
      end

    end
  end
end

