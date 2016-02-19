class RedmineZipAttachmentsHookListener < Redmine::Hook::ViewListener
  render_on :view_issues_show_description_bottom, partial: "issues/zip_attachments"
end
