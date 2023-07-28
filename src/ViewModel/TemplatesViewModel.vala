public class Variables.TemplatesViewModel : GLib.Object {
    public GLib.ListStore templates { get; construct; }
    public Gtk.SingleSelection selection_model { get; construct; }

    public signal void template_selection_changed (Variables.Template template_selected);

    construct {
        templates = new GLib.ListStore (typeof (Variables.Template));
        this.selection_model = new Gtk.SingleSelection (templates);
        this.selection_model.notify["selected_item"].connect ((spec) => {
            this.template_selection_changed ((Variables.Template)this.selection_model.selected_item);
        });

        var dummy_variables = new Gee.HashMap<string, string> ();
        dummy_variables["name"] = "Colin";
        dummy_variables["email"] = "nospamplz@gmail.com";

        templates.append (new Variables.Template () {
            name = "Demo Template",
            variables = dummy_variables
        });
    }
}