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

        //  var dummy_variables = new Gee.HashMap<string, string> ();
        //  dummy_variables["name"] = "Colin";
        //  dummy_variables["email"] = "nospamplz@gmail.com";

        var dummy_variables = new Gee.ArrayList<Variables.Variable>.wrap ({
            new Variables.Variable () {
                name = "name",
                value = "Colin"
            },
            new Variables.Variable () {
                name = "email",
                value = "nospamplz@gmail.com"
            } 
        });

        templates.append (new Variables.Template () {
            name = "Demo Template",
            variables = dummy_variables,
            content = "User Info\n\nName: {{name}}\nemail: {{email}}\n"
        });

        //  var other_variables = new Gee.HashMap<string, string> ();
        //  other_variables["title"] = "Hello World";

        var other_variables = new Gee.ArrayList<Variables.Variable>.wrap ({
            new Variables.Variable () { 
                name = "title",
                value = "Hello World"
            },
        });

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