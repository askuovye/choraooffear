function dialogue_start(_text, _duration = 300) {
    var _dialogue = instance_find(obj_dialogue_controller, 0);

    if (_dialogue == noone) {
        show_debug_message("ERRO: obj_dialogue_controller não existe.");
        return;
    }

    _dialogue.dialog_active = true;

    _dialogue.text = _text;

    _dialogue.timer = _duration;
    _dialogue.duration = _duration;
}