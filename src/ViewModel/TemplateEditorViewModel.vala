public class Variables.TemplateEditorViewModel : GLib.Object {
    public Variables.Template model { get; set; }

    public void load_template (Variables.Template template) {
        model = template;
        print ("Model Content: %s\n", model.content);
    }
}