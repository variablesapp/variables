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
        bool is_container_null = container == null;

        this.templates_view_model = new Variables.TemplatesViewModel ();
        this.variables_view_model = new Variables.VariablesViewModel ();
        this.template_editor_view_model = new Variables.TemplateEditorViewModel ();

        this.templates_view_model.template_selection_changed.connect ((template) => {
            this._selected_template = template;
            this.variables_view_model.load_variables (this._selected_template);
            this.template_editor_view_model.load_template (this._selected_template);
        });

        if (this.templates_view_model.selection_model.selected_item != null) {
            this._selected_template = (Variables.Template) this.templates_view_model.selection_model.selected_item;
            this.variables_view_model.load_variables (this._selected_template);
            this.template_editor_view_model.load_template (this._selected_template);
        }

        container.bind_instance (typeof (Variables.TemplatesViewModel), this.templates_view_model);
        container.bind_instance (typeof (Variables.VariablesViewModel), this.variables_view_model);
        container.bind_instance (typeof (Variables.TemplateEditorViewModel), this.template_editor_view_model);
    }

}