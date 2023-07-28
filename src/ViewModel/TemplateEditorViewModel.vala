public class Variables.TemplateEditorViewModel : GLib.Object {
    public Variables.Template model { get; set; }

    public string content {
        get {
            return this._content;
        }

        construct set {
            if (value != this._content) {
                this._content = value;
                model.content = this._content;
            }
        }
    }

    private string _content;

    construct {
        this._content = "";
    }


    public void load_template (Variables.Template template) {
        this.model = template;
        this.content = this.model.content;
    }
}