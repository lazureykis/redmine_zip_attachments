require 'redmine_zip_attachments_hook_listener'

Redmine::Plugin.register :redmine_zip_attachments do
  name 'Zip Attachments'
  author 'Pavel Lazureykis'
  description 'Download all attachments in one .zip archive.'
  version '0.0.1'
  url 'https://github.com/lazureykis/redmine_zip_attachments'
  author_url 'https://github.com/lazureykis'
end

Redmine::AccessControl.map do |ac|
  ac.project_module :issue_tracking do |map|
    map.permission :download_zipped_attachments, {:issues => :download_zipped_attachments}, :require => :loggedin
  end
end

IssuesController.include RedmineZipAttachments::IssuesControllerPatch
