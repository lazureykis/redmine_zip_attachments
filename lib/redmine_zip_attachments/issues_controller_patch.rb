require 'zip'

module RedmineZipAttachments
  module IssuesControllerPatch
    def self.included(base)
      base.skip_before_action :authorize, only: [:download_zipped_attachments]
    end

    def download_zipped_attachments
      find_issue
      fail Unauthorized unless User.current.allowed_to?(:download_zipped_attachments, @project)

      begin
        temp_file = Tempfile.new('attachments')
        Zip::OutputStream.open(temp_file.path) do |zos|
          @issue.attachments.each_with_index do |file, index|
            next unless File.exist?(file.diskfile)
            zos.put_next_entry("#{index}_#{file.filename}")
            zos << IO.binread(file.diskfile)
          end
        end
        send_file temp_file,
          type: 'application/zip',
          x_sendfile: true,
          filename: "Issue #{ @issue.id } attachments.zip"
      ensure
        temp_file.close
      end
    end
  end
end
