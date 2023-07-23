public class Variables.TemplatesViewModel: GLib.Object {
    public GLib.ListStore templates { get; construct; }

    construct {
        templates = new GLib.ListStore (typeof (Variables.Template));

        var dummy_variables = new Gee.HashMap<string, string> ();
        dummy_variables["name"] = "Colin";
        dummy_variables["email"] = "nospamplz@gmail.com";

        templates.append (new Variables.Template () {
            name = "Demo Template",
            variables = dummy_variables
        });
    }
}