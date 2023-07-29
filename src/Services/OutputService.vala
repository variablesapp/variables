public class Variables.OutputService : GLib.Object {
    private global::Template.Template template;

    construct {
        this.template = new global::Template.Template (null);
    }

    public string process_template (Variables.Template template_data) {
        try {
            template.parse_string (template_data.content);
            print ("Template data content: %s", template_data.content);
            var scope = new global::Template.Scope ();

            template_data.variables.foreach ((key, value) => {
                var symbol = scope.get (key);
                symbol.assign_string (value);
            });

            string expanded = template.expand_string (scope);
            print ("Expanded string: %s\n", expanded);

            return expanded ?? "Error: Template not confugred properly";

        } catch (GLib.Error ex) {
            print ("%s\n", ex.message);
            //  stderr.printf ("%s\n", ex.message);
            return ex.message;
        }
    }
}
