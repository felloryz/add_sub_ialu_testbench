//      // verilator_coverage annotation
        /// Copyright by Syntacore LLC © 2016-2021. See LICENSE for details
        /// @file       <scr1_search_ms1.svh>
        /// @brief      Most significant one search function
        ///
        
        `ifndef SCR1_SEARCH_MS1_SVH
        `define SCR1_SEARCH_MS1_SVH
        
        //-------------------------------------------------------------------------------
        // Local types declaration
        //-------------------------------------------------------------------------------
        typedef struct {
            logic       vd;
            logic       idx;
        } type_scr1_search_one_2_s;
        
        typedef struct {
            logic           vd;
            logic [4:0]     idx;
        } type_scr1_search_one_32_s;
        
        //-------------------------------------------------------------------------------
        // Leading Zeros Count Function
        //-------------------------------------------------------------------------------
%000000 function automatic type_scr1_search_one_2_s scr1_lead_zeros_cnt_2(
            input   logic [1:0]     din
        );
            type_scr1_search_one_2_s tmp;
%000000 begin
%000000     tmp.vd  = |din;
%000000     tmp.idx = ~din[1];
%000000     return  tmp;
        end
        endfunction : scr1_lead_zeros_cnt_2
        
%000000 function automatic logic [4:0] scr1_lead_zeros_cnt_32(
            input   logic [31:0]    din
        );
%000000 begin
            logic [15:0]    stage1_vd;
            logic [7:0]     stage2_vd;
            logic [3:0]     stage3_vd;
            logic [1:0]     stage4_vd;
        
            logic           stage1_idx [15:0];
            logic [1:0]     stage2_idx [7:0];
            logic [2:0]     stage3_idx [3:0];
            logic [3:0]     stage4_idx [1:0];
            type_scr1_search_one_32_s tmp;
            logic [4:0]     res;
        
            // Stage 1
%000000     for (int unsigned i=0; i<16; ++i) begin
                type_scr1_search_one_2_s tmp;
%000000         tmp = scr1_lead_zeros_cnt_2(din[(i+1)*2-1-:2]);
%000000         stage1_vd[i]  = tmp.vd;
%000000         stage1_idx[i] = tmp.idx;
            end
        
            // Stage 2
%000000     for (int unsigned i=0; i<8; ++i) begin
                type_scr1_search_one_2_s tmp;
%000000         tmp = scr1_lead_zeros_cnt_2(stage1_vd[(i+1)*2-1-:2]);
%000000         stage2_vd[i]  = tmp.vd;
%000000         stage2_idx[i] = (tmp.idx) ? {tmp.idx, stage1_idx[2*i]} : {tmp.idx, stage1_idx[2*i+1]};
            end
        
            // Stage 3
%000000     for (int unsigned i=0; i<4; ++i) begin
                type_scr1_search_one_2_s tmp;
%000000         tmp = scr1_lead_zeros_cnt_2(stage2_vd[(i+1)*2-1-:2]);
%000000         stage3_vd[i]  = tmp.vd;
%000000         stage3_idx[i] = (tmp.idx) ? {tmp.idx, stage2_idx[2*i]} : {tmp.idx, stage2_idx[2*i+1]};
            end
        
            // Stage 4
%000000     for (int unsigned i=0; i<2; ++i) begin
                type_scr1_search_one_2_s tmp;
%000000         tmp = scr1_lead_zeros_cnt_2(stage3_vd[(i+1)*2-1-:2]);
%000000         stage4_vd[i]  = tmp.vd;
%000000         stage4_idx[i] = (tmp.idx) ? {tmp.idx, stage3_idx[2*i]} : {tmp.idx, stage3_idx[2*i+1]};
            end
        
            // Stage 5
%000000     tmp.vd = |stage4_vd;
%000000     tmp.idx = (stage4_vd[1]) ? {1'b0, stage4_idx[1]} : {1'b1, stage4_idx[0]};
        
%000000     res = tmp.idx;
        
%000000     return res;
        end
        endfunction : scr1_lead_zeros_cnt_32
        
        `endif // SCR1_SEARCH_MS1_SVH
        
