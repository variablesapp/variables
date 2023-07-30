public class Variables.TemplateViewModel : GLib.Object {
    public Variables.Template model { get; set; }

    // Two way bind
    public string input_content {
        get {
            return this._input_content;
        }

        construct set {
            if (value != this._input_content) {
                this._input_content = value;
                model.content = this._input_content;
            }
        }
    }

    public string output_content { get; set; }

    public string current_view_name {
        get {
            return this._current_view_name;
        }

        set {
            print ("Set current view name: %s\n", value);
            if (value != this._current_view_name) {

                if (value == Config.TEMPLATE_OUTPUT_PAGE_NAME) {
                    print ("About to update output content\n");
                    this.output_content = this._output_service.process_template (model);
                }

                this._current_view_name = value;
            }
        }
    }

    private string _input_content;
    private string _current_view_name;
    private Variables.OutputService _output_service;

    construct {
        this._current_view_name = Config.TEMPLATE_INPUT_PAGE_NAME;
        this._input_content = "";
        this._output_service = new Variables.OutputService ();
    }

    public void load_template (Variables.Template template) {
        this.model = template;
        this.output_content = "";
        this.current_view_name = Config.TEMPLATE_INPUT_PAGE_NAME;
        this.input_content = this.model.content;
    }

    public void request_output_update () {
        if (this._current_view_name == Config.TEMPLATE_INPUT_PAGE_NAME) {
            return;
        }

        Variables.Debouncer.instance.debounce (() => {
            this.output_content = this._output_service.process_template (model);
        }, 300, Config.OUTPUT_UPDATE_DEBOUNCE_KEY);
    }
}