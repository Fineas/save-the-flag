module save_the_flag::Router {

    // ---------------------------------------------------
    // DEPENDENCIES
    // ---------------------------------------------------

    use sui::tx_context::{TxContext};
    use sui::coin::{Coin};

    use save_the_flag::OtterSwap;
    use save_the_flag::OtterLoan;

    // ---------------------------------------------------
    // FUNCTIONS
    // ---------------------------------------------------

    public entry fun swap<CoinIn, CoinOut>( liquidity_pool: &mut OtterSwap::Pool<CoinIn, CoinOut>, coin_in: Coin<CoinIn>, ctx: &mut TxContext ) {
        OtterSwap::swap<CoinIn, CoinOut>(liquidity_pool, coin_in, ctx);
    }

    public entry fun add_liquidity<CoinTypeA, CoinTypeB>( liquidity_pool: &mut OtterSwap::Pool<CoinTypeA, CoinTypeB>, coin_a: Coin<CoinTypeA>, coin_b: Coin<CoinTypeB>, ctx: &mut TxContext ) {
        OtterSwap::add_liquidity<CoinTypeA, CoinTypeB>(liquidity_pool, coin_a, coin_b, ctx);
    }

    public entry fun remove_liquidity<CoinTypeA, CoinTypeB>( liquidity_pool: &mut OtterSwap::Pool<CoinTypeA, CoinTypeB>, lps: Coin<OtterSwap::LP<CoinTypeA, CoinTypeB>>, vec: vector<u64>, ctx: &mut TxContext ) {
        OtterSwap::remove_liquidity<CoinTypeA, CoinTypeB>(liquidity_pool, lps, vec, ctx);
    }

    public entry fun create_pool<CoinTypeA, CoinTypeB>( ctx: &mut TxContext ) {
        OtterSwap::create_pool<CoinTypeA, CoinTypeB>(ctx);
    }

    public fun loan<CoinOut>( lender: &mut OtterLoan::FlashLender<CoinOut>, amount: u64, ctx: &mut TxContext ) : (Coin<CoinOut>, OtterLoan::Receipt<CoinOut>) {
        OtterLoan::loan<CoinOut>(lender, amount, ctx)
    }

    public fun repay<CoinIn>( lender: &mut OtterLoan::FlashLender<CoinIn>, payment: Coin<CoinIn>, receipt: OtterLoan::Receipt<CoinIn> ) {
        OtterLoan::repay<CoinIn>(lender, payment, receipt);
    }

    public entry fun lend<CoinType>( to_lend: Coin<CoinType>, fee: u64, ctx: &mut TxContext ) {
        OtterLoan::create<CoinType>(to_lend, fee, ctx);
    }

    public entry fun withdraw<CoinOut>( lender: &mut OtterLoan::FlashLender<CoinOut>, admin_cap: &OtterLoan::AdminCapability, amount: u64, ctx: &mut TxContext ) {
        OtterLoan::withdraw<CoinOut>(lender, admin_cap, amount, ctx);
    }

    public entry fun deposit<CoinIn>( lender: &mut OtterLoan::FlashLender<CoinIn>, admin_cap: &OtterLoan::AdminCapability, coins: Coin<CoinIn>, ctx: &mut TxContext ) {
        OtterLoan::deposit<CoinIn>(lender, admin_cap, coins, ctx);
    }
}