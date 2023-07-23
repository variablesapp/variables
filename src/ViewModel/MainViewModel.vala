public class Variables.MainViewModel : GLib.Object {
    public Vdi.Container container { get; construct; }
    public Variables.TemplatesViewModel templates_view_model { get; construct; }
    public Variables.VariablesViewModel variables_view_model { get; construct; }

    private Variables.Template _selected_template;

    public MainViewModel (Vdi.Container container) {
        Object (container: container);
    }

    construct {
        bool is_container_null = container == null;
        print ("Is container null: %s\n", is_container_null ? "true" : "false");

        this.templates_view_model = new Variables.TemplatesViewModel ();
        this.variables_view_model = new Variables.VariablesViewModel ();

        this.templates_view_model.template_selection_changed.connect ((template) => {
            this._selected_template = template;
            this.variables_view_model.load_variables (this._selected_template);
        });

        container.bind_instance (typeof (Variables.TemplatesViewModel), templates_view_model);
        container.bind_instance (typeof (Variables.VariablesViewModel), variables_view_model);
    }

}