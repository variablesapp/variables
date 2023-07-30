public class Variables.OutputService : GLib.Object {
    private global::Template.Template template;

    construct {
        this.template = new global::Template.Template (null);
    }

    public string process_template (Variables.Template template_data) {
        try {
            template.parse_string (template_data.content);
            var scope = new global::Template.Scope ();

            template_data.variables.foreach ((entry) => {
                var symbol = scope.get (entry.key);
                symbol.assign_string (entry.value);
                return true;
            });

            string expanded = template.expand_string (scope);

            return expanded ?? "Error: Template not confugred properly";

        } catch (GLib.Error ex) {
            critical ("%s\n", ex.message);
            return ex.message;
        }
    }
}
