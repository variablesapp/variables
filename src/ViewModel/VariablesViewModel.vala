public class Variables.VariablesViewModel : GLib.Object {
    public GLib.ListStore variables { get; construct; }
    public Gtk.NoSelection selection_model { get; construct; }

    construct {
        this.variables = new GLib.ListStore (typeof (Variables.Variable));
        this.selection_model = new Gtk.NoSelection (this.variables);
    }

    public void load_variables (Variables.Template template) {
        this.variables.remove_all ();

        template.variables.foreach ((key, value) => {
            this.variables.append (new Variables.Variable () {
                name = key,
                value = value
            });
        });
    }
}