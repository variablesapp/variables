public class Variables.VariablesViewModel : GLib.Object {
    public Variables.Template template;
    public GLib.ListStore variables { get; construct; }
    public Gtk.NoSelection selection_model { get; construct; }

    public signal void variable_property_changed ();

    construct {
        this.variables = new GLib.ListStore (typeof (Variables.Variable));
        this.selection_model = new Gtk.NoSelection (this.variables);
    }

    public void load_variables (Variables.Template template) {
        this.template = template;

        this.variables.remove_all ();

        template.variables.foreach ((entry) => {
            this.variables.append (new Variables.Variable () {
                name = entry.name,
                value = entry.value,
            });

            return true;
        });
    }

    public void update_variable (Variables.EditableFieldChangeType change_type, uint changed_position, string content) {
        var variable = (Variables.Variable)variables.get_item (changed_position);
        switch (change_type) {
            case Variables.EditableFieldChangeType.Name:
                template.variables[(int)changed_position].name = content;
                variable.name = content;
                break;
            case Variables.EditableFieldChangeType.Value:
                template.variables[(int)changed_position].value = content;
                variable.value = content;
                break;
        }

        this.variable_property_changed ();
    }
}