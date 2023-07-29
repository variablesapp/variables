public class Variables.TemplatesViewModel : GLib.Object {
    public GLib.ListStore templates { get; construct; }
    public Gtk.SingleSelection selection_model { get; construct; }

    public signal void template_selection_changed (Variables.Template template_selected);

    construct {
        templates = new GLib.ListStore (typeof (Variables.Template));
        this.selection_model = new Gtk.SingleSelection (templates) {
            autoselect = true
        };

        this.selection_model.notify["selected-item"].connect ((spec) => {
            this.template_selection_changed ((Variables.Template)this.selection_model.selected_item);
        });

        var dummy_variables = new GLib.HashTable<string, string> (str_hash, str_equal);
        dummy_variables["name"] = "Colin";
        dummy_variables["email"] = "nospamplz@gmail.com";

        templates.append (new Variables.Template () {
            name = "Demo Template",
            variables = dummy_variables,
            content = "This is Demo Content!"
        });

        var other_variables = new GLib.HashTable<string, string> (str_hash, str_equal);
        other_variables["title"] = "Hello World";

        templates.append (new Variables.Template () {
            name = "Second Template",
            variables = other_variables,
            content = "Other content"
        });

        if (this.templates.get_n_items () < 1) {
            return;
        }
    }
}