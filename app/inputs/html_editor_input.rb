class HtmlEditorInput < Formtastic::Inputs::TextInput
  def toolbar
    <<-HTML
    <div id="#{input_html_options[:id]}-toolbar" class="active_admin_editor_toolbar">
      
      <a data-wysihtml5-action="change_view"><span>Source</span></a>
      <a data-wysihtml5-command="bold" title="Bold"><span>Bold</span></a>
      <a data-wysihtml5-command="italic" title="Italic"><span>Italic</span></a>
      <a data-wysihtml5-command="createLink" title="Link"><span>Link</span></a>
      #{%Q{<a class="button quicksave" href="#">Save</a>} if input_html_options[:quicksave]}

      <div data-wysihtml5-dialog="createLink" style="display: none">
        <label>
          Link:
          <input data-wysihtml5-dialog-field="href" value="http://">
        </label>
        <div class="action-group">
          <a data-wysihtml5-dialog-action="save" class="button">OK</a>
          <a data-wysihtml5-dialog-action="cancel">Cancel</a>
        </div>
      </div>
      
    </div>
    HTML
  end

  def input_html_options
    {
      quicksave: false
    }.merge(super)
  end

  def to_html
    html = '<div class="active_admin_editor">'
    html << toolbar.html_safe
    html << builder.text_area(method, input_html_options)
    html << '</div>'
    html << '<div style="clear: both"></div>'
    input_wrapping do
      label_html << html.html_safe
    end
  end
end
