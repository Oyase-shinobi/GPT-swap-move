module swap_account::AnimeLiquid{

    use liquidswap::router;
    use liquidswap::curves::Uncorrelated;
    use liquidswap::curves::Stable;
    use cetus_amm::amm_swap;
    use cetus_amm::amm_router;
    use pancake::swap;
    use pancake::swap_utils;
    use aux::amm;
          
    #[view]
    public fun get_amount_out__liquid_Uncorrelated<X, Y>(amount_in: u64): u64 {
    let coin_out_val = router::get_amount_out<X, Y, Uncorrelated>(amount_in);
    (coin_out_val)
    }
    // 2:"0x190d44266241744264b964a37b8f09863167a12d3e70cda39376cfb4e3561e12::curves::Uncorrelated"
    //100000000 to 5669811 

    #[view]
    public fun get_amount_in_liquid_Uncorrelated<X, Y>(amount_out: u64): u64 {
    let value = router::get_amount_in<X, Y, Uncorrelated>(amount_out);
    (value)// ex: 30 for 0.3%
    }
    // usdt to apt
    // 2:"0x190d44266241744264b964a37b8f09863167a12d3e70cda39376cfb4e3561e12::curves::Uncorrelated"
    //5000000 to 285501 

    #[view]
    public fun get_amount_out_liquid_Stable<X, Y>(amount_in: u64): u64 {
    let coin_out_val = router::get_amount_out<X, Y, Stable>(amount_in);
    (coin_out_val)
    }
    // 2:"0x190d44266241744264b964a37b8f09863167a12d3e70cda39376cfb4e3561e12::curves::Uncorrelated"
    //100000000 to 5538261 

    #[view]
    public fun get_amount_in_liquid_Stable<X, Y>(amount_out: u64): u64 {
    let value = router::get_amount_in<X, Y, Stable>(amount_out);
    (value)// ex: 30 for 0.3%
    }
    //usdt to aptos
    // 2:"0x190d44266241744264b964a37b8f09863167a12d3e70cda39376cfb4e3561e12::curves::Uncorrelated"
    //5000000 to 285136 


    #[view]
    public fun get_amount_out_liquid_Uncorrelated_fee<X, Y>(amount_in: u64,fee_bips: u8): u64 {
    let coin_out_val = router::get_amount_out<X, Y, Uncorrelated>(amount_in);
    (coin_out_val - (coin_out_val * (fee_bips as u64) / 10000))
    }
    // 2:"0x190d44266241744264b964a37b8f09863167a12d3e70cda39376cfb4e3561e12::curves::Uncorrelated"
    //100000000 to 5659513 

    #[view]
    public fun get_amount_in_liquid_Uncorrelated_fee<X, Y>(amount_out: u64,fee_bips: u8): u64 {
    let value = router::get_amount_in<X, Y, Uncorrelated>(amount_out);
    (value + (value * (fee_bips as u64) / 10000))// ex: 30 for 0.3%
    }

    #[view]
    public fun get_amount_out_liquid_Stable_fee<X, Y>(amount_in: u64,fee_bips: u8): u64 {
    let coin_out_val = router::get_amount_out<X, Y, Stable>(amount_in);
    (coin_out_val - (coin_out_val * (fee_bips as u64) / 10000))
    }

    #[view]
    public fun get_amount_in_liquid_Stable_fee<X, Y>(amount_out: u64,fee_bips: u8): u64 {
    let value = router::get_amount_in<X, Y, Stable>(amount_out);
    (value + (value * (fee_bips as u64) / 10000))// ex: 30 for 0.3%
    }
    
    #[view]
    public fun get_amount_out_cetus_without_fee<X, Y>(amount_a_in: u128): u128 {
        let is_forward = amm_swap::get_pool_direction<X, Y>();
        let x_out = amm_router::compute_b_out<X, Y>(amount_a_in, is_forward);
        x_out
    }
    //100000000 to 5865411 
    
    #[view]
    public fun get_amount_out_cetus_with_fee<X, Y>(amount_a_in: u128,fee_bips: u8): u128 {
        let is_forward = amm_swap::get_pool_direction<X, Y>();
        let x_out = amm_router::compute_b_out<X, Y>(amount_a_in, is_forward);
        (x_out - (x_out * (fee_bips as u128) / 10000))// ex: 30 for 0.3%
    }
    //100000000 to 5865411 
    
    #[view]
    public fun get_amount_in_cetus_without_fee<X, Y>(amount_b_out: u128): u128 {
        let is_forward = amm_swap::get_pool_direction<X, Y>();
        let x_in = amm_router::compute_a_in<X, Y>(amount_b_out, is_forward);
        x_in
    }
    
    #[view]
    public fun get_amount_in_cetus_with_fee<X, Y>(amount_b_out: u128,fee_bips: u8): u128 {
        let is_forward = amm_swap::get_pool_direction<X, Y>();
        let x_in = amm_router::compute_a_in<X, Y>(amount_b_out, is_forward);
        (x_in + (x_in * (fee_bips as u128) / 10000))// ex: 30 for 0.3%
    }
    
    #[view]
    public fun get_amount_in_pancake_without_fee<X, Y>(amount_b_out: u64): u64 {
        let (rin, rout, _) = swap::token_reserves<X, Y>();
        let amount_in = swap_utils::get_amount_in(amount_b_out, rin, rout);
        (amount_in)
    }
    //5000000 to 89352268
    
    #[view]
    public fun get_amount_in_pancake_with_fee<X, Y>(amount_b_out: u64,fee_bips: u8): u64 {
        let (rin, rout, _) = swap::token_reserves<X, Y>();
        let amount_in = swap_utils::get_amount_in(amount_b_out, rin, rout);
        (amount_in + (amount_in * (fee_bips as u64) / 10000))// ex: 30 for 0.3%
    }
    
    #[view]
    public fun get_amount_out_pancake_without_fee<X, Y>(amount_b_in: u64): u64 {
        let (rin, rout, _) = swap::token_reserves<X, Y>();
        let amount_out = swap_utils::get_amount_out(amount_b_in, rin, rout);
        (amount_out)
    }
    //1000000 to 5600766 
    
    #[view]
    public fun get_amount_out_pancake_with_fee<X, Y>(amount_b_in: u64,fee_bips: u8): u64 {
        let (rin, rout, _) = swap::token_reserves<X, Y>();
        let amount_out = swap_utils::get_amount_out(amount_b_in, rin, rout);
        (amount_out - (amount_out * (fee_bips as u64) / 10000))// ex: 30 for 0.3%
    }

    #[view]
    public fun get_amount_in_Aux_without_fee<X, Y>(amount_b_out: u64): u64 {
        let amount_in = amm::au_in<X, Y>(amount_b_out);
        (amount_in)
    }
    //5000000 to 18357475
    
    #[view]
    public fun get_amount_in_Aux_with_fee<X, Y>(amount_b_out: u64,fee_bips: u8): u64 {
        let amount_in = amm::au_in<X, Y>(amount_b_out);
        (amount_in + (amount_in * (fee_bips as u64) / 10000))// ex: 30 for 0.3%
    }
    
    #[view]
    public fun get_amount_out_Aux_without_fee<X, Y>(amount_b_in: u64): u64 {
        let amount_out = amm::au_out<X, Y>(amount_b_in);
        (amount_out)
    }
    //1000000 to 54493 
    
    #[view]
    public fun get_amount_out_Aux_with_fee<X, Y>(amount_b_in: u64,fee_bips: u8): u64 {
        let amount_out = amm::au_out<X, Y>(amount_b_in);
        (amount_out - (amount_out * (fee_bips as u64) / 10000))// ex: 30 for 0.3%
    }
    // 0:"0x1::aptos_coin::AptosCoin"
    // 1:"0xf22bede237a07e121b56d91a491eb7bcdfd1f5907926a9e58338f964a01b17fa::asset::USDT"
    //1000000 to 54330 
     

}
