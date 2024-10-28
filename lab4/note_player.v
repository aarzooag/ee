module note_player(
    input clk,
    input reset,
    input play_enable,  // When high we play, when low we don't.
    input [5:0] note_to_load,  // The note to play
    input [5:0] duration_to_load,  // The duration of the note to play
    input load_new_note,  // Tells us when we have a new note to load
    output done_with_note,  // When we are done with the note this stays high.
    input beat,  // This is our 1/48th second beat
    input generate_next_sample,  // Tells us when the codec wants a new sample
    output [15:0] sample_out,  // Our sample output
    output new_sample_ready  // Tells the codec when we've got a sample
);

    wire [6:0] duration, next_duration;

    //KEEP TRACK OF HOW LONG TO PLAY NOTE 

    assign next_duration = beat ? duration + 1'd1 : duration;

    dffre #(7) sample_counter(.clk(clk), .r(reset | duration == duration_to_load), .en(play_enable), .d(next_duration), .q(duration));

    assign done_with_note = (duration == duration_to_load);


    //GET FREQUENCY -> SINE READER IF PLAY IS high
    
    wire[5:0] cur_note;
    wire[19:0] step_size, note_freq;

    //flip flop for note that is playing
    dffre #(6) note_fff(.clk(clk), .r(reset), .en(load_new_note), .q(cur_note));

    frequency_rom get_note_f(.clk(clk), .addr(cur_note), .dout(note_freq));

    assign step_size = play_enable ? note_freq : 20'b0;

    sine_reader wave(.clk(clk), .reset(reset), 
                            .step_size(step_size),
                             .generate_next(generate_next_sample),
                             .sample_ready(new_sample_ready), 
                             .sample(sample_out));



    //wait for next_sample request. when request is high send to codec_conditioner -> new sample ready


endmodule
