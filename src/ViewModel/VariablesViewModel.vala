public class Variables.VariablesViewModel : GLib.Object {
    public GLib.ListStore variables { get; set;}

    public void load_variables (Variables.Template template) {
        template.variables.foreach ((entry) => {
            variables.append (new Variables.Variable () {
                name = entry.key,
                value = entry.value
            });

            return true;
        });
    }
}