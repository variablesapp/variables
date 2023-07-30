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
                name = entry.key,
                value = entry.value,
            });

            return true;
        });
    }

    public void update_variable (Variables.EditableFieldChangeType change_type, uint changed_position, string content) {
        var variable = (Variables.Variable)variables.get_item (changed_position);
        switch (change_type) {
            case Variables.EditableFieldChangeType.Name:
                string old_value;
                template.variables.unset (variable.name, out old_value);
                template.variables[content] = old_value;
                variable.name = content;
                break;
            case Variables.EditableFieldChangeType.Value:
                template.variables[variable.name] = content;
                variable.value = content;
                break;
        }

        template.variables[variable.name] = variable.value;

        this.variable_property_changed ();
    }
}