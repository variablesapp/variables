public class Variables.MainViewModel : GLib.Object {
    public Vdi.Container container { get; construct; }
    public Variables.TemplatesViewModel templates_view_model { get; construct; }
    public Variables.VariablesViewModel variables_view_model { get; construct; }
    public Variables.TemplateEditorViewModel template_editor_view_model { get; construct; }

    private Variables.Template _selected_template;

    public MainViewModel (Vdi.Container container) {
        Object (container: container);

    }

    construct {
        this.templates_view_model = new Variables.TemplatesViewModel ();
        this.variables_view_model = new Variables.VariablesViewModel ();
        this.template_editor_view_model = new Variables.TemplateEditorViewModel ();

        this.templates_view_model.template_selection_changed.connect ((template) => {
            if (template == null || template == this._selected_template) {
                return;
            }

            this.update_template (template);
        });

        if (this.templates_view_model.selection_model.selected_item != null) {
            this.update_template ((Variables.Template) this.templates_view_model.selection_model.selected_item);
        }

        container.bind_instance (typeof (Variables.TemplatesViewModel), this.templates_view_model);
        container.bind_instance (typeof (Variables.VariablesViewModel), this.variables_view_model);
        container.bind_instance (typeof (Variables.TemplateEditorViewModel), this.template_editor_view_model);
    }

    private void update_template (Variables.Template template) {
        this._selected_template = template;
        this.variables_view_model.load_variables (this._selected_template);
        this.template_editor_view_model.load_template (this._selected_template);
    }

}