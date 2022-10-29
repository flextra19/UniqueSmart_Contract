// SPDX-License-Identifier: Unlicensed

/*
    ██╗   ██╗███╗   ██╗██╗ ██████╗ ██╗   ██╗███████╗███████╗███╗   ███╗ █████╗ ██████╗ ████████╗    
    ██║   ██║████╗  ██║██║██╔═══██╗██║   ██║██╔════╝██╔════╝████╗ ████║██╔══██╗██╔══██╗╚══██╔══╝    
    ██║   ██║██╔██╗ ██║██║██║   ██║██║   ██║█████╗  ███████╗██╔████╔██║███████║██████╔╝   ██║       
    ██║   ██║██║╚██╗██║██║██║▄▄ ██║██║   ██║██╔══╝  ╚════██║██║╚██╔╝██║██╔══██║██╔══██╗   ██║       
    ╚██████╔╝██║ ╚████║██║╚██████╔╝╚██████╔╝███████╗███████║██║ ╚═╝ ██║██║  ██║██║  ██║   ██║       
     ╚═════╝ ╚═╝  ╚═══╝╚═╝ ╚══▀▀═╝  ╚═════╝ ╚══════╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝ 
*/
 
// SMART PROTOCOL COPYRIGHT (C) 2022 

pragma solidity ^0.7.4;

library SafeMathInt {
    int256 private constant MIN_INT256 = int256(1) << 255;
    int256 private constant MAX_INT256 = ~(int256(1) << 255);

    function mul(int256 a, int256 b) internal pure returns (int256) {
        int256 c = a * b;

        require(c != MIN_INT256 || (a & MIN_INT256) != (b & MIN_INT256));
        require((b == 0) || (c / b == a));
        return c;
    }

    function div(int256 a, int256 b) internal pure returns (int256) {
        require(b != -1 || a != MIN_INT256);

        return a / b;
    }
 
    function sub(int256 a, int256 b) internal pure returns (int256) {
        int256 c = a - b;
        require((b >= 0 && c <= a) || (b < 0 && c > a));
        return c;
    }

    function add(int256 a, int256 b) internal pure returns (int256) {
        int256 c = a + b;
        require((b >= 0 && c >= a) || (b < 0 && c < a));
        return c;
    }

    function abs(int256 a) internal pure returns (int256) {
        require(a != MIN_INT256);
        return a < 0 ? -a : a;
    }
}

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;

        return c;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0);
        return a % b;
    }
}

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address who) external view returns (uint256);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function transfer(address to, uint256 value) external returns (bool);

    function approve(address spender, uint256 value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

interface IPancakeSwapPair {
		event Approval(address indexed owner, address indexed spender, uint value);
		event Transfer(address indexed from, address indexed to, uint value);

		function name() external pure returns (string memory);
		function symbol() external pure returns (string memory);
		function decimals() external pure returns (uint8);
		function totalSupply() external view returns (uint);
		function balanceOf(address owner) external view returns (uint);
		function allowance(address owner, address spender) external view returns (uint);

		function approve(address spender, uint value) external returns (bool);
		function transfer(address to, uint value) external returns (bool);
		function transferFrom(address from, address to, uint value) external returns (bool);

		function DOMAIN_SEPARATOR() external view returns (bytes32);
		function PERMIT_TYPEHASH() external pure returns (bytes32);
		function nonces(address owner) external view returns (uint);

		function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

		event Mint(address indexed sender, uint amount0, uint amount1);
		event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
		event Swap(
				address indexed sender,
				uint amount0In,
				uint amount1In,
				uint amount0Out,
				uint amount1Out,
				address indexed to
		);
		event Sync(uint112 reserve0, uint112 reserve1);

		function MINIMUM_LIQUIDITY() external pure returns (uint);
		function factory() external view returns (address);
		function token0() external view returns (address);
		function token1() external view returns (address);
		function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
		function price0CumulativeLast() external view returns (uint);
		function price1CumulativeLast() external view returns (uint);
		function kLast() external view returns (uint);

		function mint(address to) external returns (uint liquidity);
		function burn(address to) external returns (uint amount0, uint amount1);
		function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
		function skim(address to) external;
		function sync() external;

		function initialize(address, address) external;
}

interface IPancakeSwapRouter{
		function factory() external pure returns (address);
		function WETH() external pure returns (address);

		function addLiquidity(
				address tokenA,
				address tokenB,
				uint amountADesired,
				uint amountBDesired,
				uint amountAMin,
				uint amountBMin,
				address to,
				uint deadline
		) external returns (uint amountA, uint amountB, uint liquidity);
		function addLiquidityETH(
				address token,
				uint amountTokenDesired,
				uint amountTokenMin,
				uint amountETHMin,
				address to,
				uint deadline
		) external payable returns (uint amountToken, uint amountETH, uint liquidity);
		function removeLiquidity(
				address tokenA,
				address tokenB,
				uint liquidity,
				uint amountAMin,
				uint amountBMin,
				address to,
				uint deadline
		) external returns (uint amountA, uint amountB);
		function removeLiquidityETH(
				address token,
				uint liquidity,
				uint amountTokenMin,
				uint amountETHMin,
				address to,
				uint deadline
		) external returns (uint amountToken, uint amountETH);
		function removeLiquidityWithPermit(
				address tokenA,
				address tokenB,
				uint liquidity,
				uint amountAMin,
				uint amountBMin,
				address to,
				uint deadline,
				bool approveMax, uint8 v, bytes32 r, bytes32 s
		) external returns (uint amountA, uint amountB);
		function removeLiquidityETHWithPermit(
				address token,
				uint liquidity,
				uint amountTokenMin,
				uint amountETHMin,
				address to,
				uint deadline,
				bool approveMax, uint8 v, bytes32 r, bytes32 s
		) external returns (uint amountToken, uint amountETH);
		function swapExactTokensForTokens(
				uint amountIn,
				uint amountOutMin,
				address[] calldata path,
				address to,
				uint deadline
		) external returns (uint[] memory amounts);
		function swapTokensForExactTokens(
				uint amountOut,
				uint amountInMax,
				address[] calldata path,
				address to,
				uint deadline
		) external returns (uint[] memory amounts);
		function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
				external
				payable
				returns (uint[] memory amounts);
		function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
				external
				returns (uint[] memory amounts);
		function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
				external
				returns (uint[] memory amounts);
		function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
				external
				payable
				returns (uint[] memory amounts);

		function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
		function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
		function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
		function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
		function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
		function removeLiquidityETHSupportingFeeOnTransferTokens(
			address token,
			uint liquidity,
			uint amountTokenMin,
			uint amountETHMin,
			address to,
			uint deadline
		) external returns (uint amountETH);
		function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
			address token,
			uint liquidity,
			uint amountTokenMin,
			uint amountETHMin,
			address to,
			uint deadline,
			bool approveMax, uint8 v, bytes32 r, bytes32 s
		) external returns (uint amountETH);
	
		function swapExactTokensForTokensSupportingFeeOnTransferTokens(
			uint amountIn,
			uint amountOutMin,
			address[] calldata path,
			address to,
			uint deadline
		) external;
		function swapExactETHForTokensSupportingFeeOnTransferTokens(
			uint amountOutMin,
			address[] calldata path,
			address to,
			uint deadline
		) external payable;
		function swapExactTokensForETHSupportingFeeOnTransferTokens(
			uint amountIn,
			uint amountOutMin,
			address[] calldata path,
			address to,
			uint deadline
		) external;
}

interface IPancakeSwapFactory {
		event PairCreated(address indexed token0, address indexed token1, address pair, uint);

		function feeTo() external view returns (address);
		function feeToSetter() external view returns (address);

		function getPair(address tokenA, address tokenB) external view returns (address pair);
		function allPairs(uint) external view returns (address pair);
		function allPairsLength() external view returns (uint);

		function createPair(address tokenA, address tokenB) external returns (address pair);

		function setFeeTo(address) external;
		function setFeeToSetter(address) external;
}

contract Ownable {
    address private _owner;

    event OwnershipRenounced(address indexed previousOwner);

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    constructor() {
        _owner = msg.sender;
    }

    function owner() public view returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(isOwner());
        _;
    }

    function isOwner() public view returns (bool) {
        return msg.sender == _owner;
    }

    function renounceOwnership() public onlyOwner {
        emit OwnershipRenounced(_owner);
        _owner = address(0);
    }

    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0));
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

abstract contract ERC20Detailed is IERC20 {
    string private _name;
    string private _symbol;
    uint8 private _decimals;

    constructor(
        string memory name_,
        string memory symbol_,
        uint8 decimals_
    ) {
        _name = name_;
        _symbol = symbol_;
        _decimals = decimals_;
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }
}

interface IWAVAXReceiver {
    function initialize(address) external;
    function withdraw() external;
    function withdrawUnsupportedAsset(address, uint256) external;
    function transferOwnership(address) external;
}

contract WAVAXReceiver is Ownable {

    address public wavax;
    address public token;

    constructor() Ownable() {
        token = msg.sender;
    }

    function initialize(address _wavax) public onlyOwner {
        require(wavax == address(0x0), "Already initialized");
        wavax = _wavax;
    }

    function withdraw() public {
        require(msg.sender == token, "Caller is not token");
        IERC20(wavax).transfer(token, IERC20(wavax).balanceOf(address(this)));
    }

    function withdrawUnsupportedAsset(address _token, uint256 _amount) public onlyOwner {
        if(_token == address(0x0))
            payable(owner()).transfer(_amount);
        else
            IERC20(_token).transfer(owner(), _amount);
    }
}

contract UniqueSmart is ERC20Detailed, Ownable {

    using SafeMath for uint256;
    using SafeMathInt for int256;

    event LogRebase(uint256 indexed epoch, uint256 totalSupply);
    event SwapEnabled();

    string public _name = "UniqueSmart";
    string public _symbol = "SMART";

    IPancakeSwapPair public pairContract;
    mapping(address => bool) _isFeeExempt;

    modifier validRecipient(address to) {
        require(to != address(0x0));
        _;
    }

    uint256 public constant DECIMALS = 18;
    uint256 public constant MAX_UINT256 = ~uint256(0);
    uint8 public constant RATE_DECIMALS = 7;
    uint256 public constant TIME_STEP = 1 days;

    uint256 private constant INITIAL_FRAGMENTS_SUPPLY = 300000 * 10 ** DECIMALS;

    uint256 public liquidityFee = 20;
    uint256 public smartInsuranceFundFee = 45;
    uint256 public treasuryFee = 50;
    uint256 public sellFee = 25;
    uint256 public blackholeFee = 25;
    uint256 public nftFee = 15;
    uint256 public totalFee = liquidityFee.add(treasuryFee).add(smartInsuranceFundFee).add(blackholeFee);
    uint256 public feeDenominator = 1000;

    uint256 public startTime;
    uint256 public sellLimit = 0;
    uint256 public holdLimit = 0;
    uint256 public limitDenominator = 10000;
    uint public sellFeeStep = 1;

    address DEAD = 0x000000000000000000000000000000000000dEaD;
    address ZERO = 0x0000000000000000000000000000000000000000;
    address WAVAX = 0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7;

    address public autoLiquidityReceiver;
    address public treasuryReceiver;
    address public smartInsuranceFundReceiver;
    address public wavaxReceiver;
    address public blackhole;
    address public nftFeeReceiver;
    address public pairAddress;
    bool public swapEnabled = false;
    IPancakeSwapRouter public router;
    address public pair;
    bool inSwap = false;
    modifier swapping() {
        inSwap = true;
        _;
        inSwap = false;
    }

    uint256 private constant TOTAL_GONS = MAX_UINT256 - (MAX_UINT256 % INITIAL_FRAGMENTS_SUPPLY);

    uint256 private constant MAX_SUPPLY = 3000000000 * 10 ** DECIMALS;

    bool public _autoRebase;
    bool public _autoAddLiquidity;
    uint256 public _initRebaseStartTime;
    uint256 public _lastRebasedTime;
    uint256 public _lastAddLiquidityTime;
    uint256 public _totalSupply;
    uint256 private _gonsPerFragment;

    mapping(address => uint256) private _gonBalances;
    mapping(address => mapping(address => uint256)) private _allowedFragments;
    mapping(address => bool) public blacklist;
    mapping(address => mapping(uint256 => uint256)) public sold;
    mapping(address => bool) public _excludeFromLimit;

    modifier checkLimit(address from, address to, uint256 value) {
        if(!_excludeFromLimit[from]) {
            require(sold[from][getCurrentDay()] + value <= getUserSellLimit(), "Cannot sell or transfer more than limit.");
        }
        _;
        if(!_excludeFromLimit[to]) {
            require(_gonBalances[to].div(_gonsPerFragment) <= getUserHoldLimit(), "Cannot buy more than limit.");
        }
    }

    constructor() ERC20Detailed("UniqueSmart", "SMART", uint8(DECIMALS)) Ownable() {
        // creating wavaxReceiver contract
        bytes memory bytecode = type(WAVAXReceiver).creationCode;
        bytes32 salt = keccak256(abi.encodePacked(WAVAX));
        address receiver;
        address initialReceiver = 0xEd59e520ff0879fc568041589d7C7429F97669CA;
        assembly {
            receiver := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }
        IWAVAXReceiver(receiver).initialize(WAVAX);

        wavaxReceiver = receiver;

        router = IPancakeSwapRouter(0x60aE616a2155Ee3d9A68541Ba4544862310933d4);
        pair = IPancakeSwapFactory(router.factory()).createPair(
            WAVAX,
            address(this)
        );
      
        autoLiquidityReceiver = 0x1F7d401A547be090ff438ae8143ac51a9015A163;
        treasuryReceiver = 0xf1fF733B2000Ea659be7adbE05F8Ac0a8D5862Eb; 
        smartInsuranceFundReceiver = 0x31DF722f7B573076d37d3D1aa47D8BCBBa86b3d1;
        nftFeeReceiver = 0x146e54E72466763550CEd7f015cda4BE46878010;
        blackhole = DEAD;

        _allowedFragments[address(this)][address(router)] = uint256(-1);
        pairAddress = pair;
        pairContract = IPancakeSwapPair(pair);

        _totalSupply = INITIAL_FRAGMENTS_SUPPLY;
        _gonBalances[initialReceiver] = TOTAL_GONS;
        _gonsPerFragment = TOTAL_GONS.div(_totalSupply);
        _initRebaseStartTime = 	1660873600;	
        _lastRebasedTime = 	1660873600;
        startTime = block.timestamp;
        _autoRebase = true;
        _autoAddLiquidity = true;
        _isFeeExempt[msg.sender] = true;
        _isFeeExempt[initialReceiver] = true;
        _isFeeExempt[treasuryReceiver] = true;
        _isFeeExempt[address(this)] = true;

        _excludeFromLimit[DEAD] = true;
        _excludeFromLimit[address(this)] = true;
        _excludeFromLimit[pair] = true;

        emit Transfer(address(0x0), treasuryReceiver, _totalSupply);
    }

    function rebase() internal {
        
        if ( inSwap ) return;
        uint256 rebaseRate;
        uint256 deltaTimeFromInit = block.timestamp - _initRebaseStartTime;
        uint256 deltaTime = block.timestamp - _lastRebasedTime;
        uint256 times = deltaTime.div(15 minutes);
        uint256 epoch = times.mul(15);

        if (deltaTimeFromInit < (365 days)) {
            rebaseRate = 2360;
        } else if (deltaTimeFromInit >= (7 * 365 days)) {
            rebaseRate = 2;
        } else if (deltaTimeFromInit >= (548 days)) {
            rebaseRate = 14;
        } else {
            rebaseRate = 211;
        }

        for (uint256 i = 0; i < times; i++) {
            _totalSupply = _totalSupply
                .mul((10**RATE_DECIMALS).add(rebaseRate))
                .div(10**RATE_DECIMALS);
        }

        _gonsPerFragment = TOTAL_GONS.div(_totalSupply);
        _lastRebasedTime = _lastRebasedTime.add(times.mul(15 minutes));

        pairContract.sync();

        emit LogRebase(epoch, _totalSupply);
    }

    function transfer(address to, uint256 value)
        external
        override
        validRecipient(to)
        returns (bool)
    {
        _transferFrom(msg.sender, to, value);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external override validRecipient(to) returns (bool) {
        
        if (_allowedFragments[from][msg.sender] != uint256(-1)) {
            _allowedFragments[from][msg.sender] = _allowedFragments[from][
                msg.sender
            ].sub(value, "Insufficient Allowance");
        }
        _transferFrom(from, to, value);
        return true;
    }

    function _basicTransfer(
        address from,
        address to,
        uint256 amount
    ) internal returns (bool) {
        uint256 gonAmount = amount.mul(_gonsPerFragment);
        _gonBalances[from] = _gonBalances[from].sub(gonAmount);
        _gonBalances[to] = _gonBalances[to].add(gonAmount);
        return true;
    }

    function _transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) internal checkLimit(sender, recipient, amount) returns (bool) {

        if(sender != owner() && recipient != owner()) {
            require(swapEnabled, "Swap is not enabled");
        }
        require(!blacklist[sender] && !blacklist[recipient], "in_blacklist");

        if (inSwap) {
            return _basicTransfer(sender, recipient, amount);
        }
        if (shouldRebase()) {
           rebase();
        }

        if (shouldAddLiquidity()) {
            addLiquidity();
        }

        if (shouldSwapBack()) {
            swapBack();
        }

        uint256 gonAmount = amount.mul(_gonsPerFragment);
        _gonBalances[sender] = _gonBalances[sender].sub(gonAmount);
        uint256 gonAmountReceived = shouldTakeFee(sender, recipient)
            ? takeFee(sender, recipient, gonAmount)
            : gonAmount;
        _gonBalances[recipient] = _gonBalances[recipient].add(
            gonAmountReceived
        );

        sold[sender][getCurrentDay()] = sold[sender][getCurrentDay()].add(amount);

        emit Transfer(
            sender,
            recipient,
            gonAmountReceived.div(_gonsPerFragment)
        );
        return true;
    }

    function takeFee(
        address sender,
        address recipient,
        uint256 gonAmount
    ) internal  returns (uint256) {
        uint256 _totalFee = totalFee;
        uint256 _liquidityFee = liquidityFee;
        uint256 _nftFee = 0;

        if (recipient == pair) {
            if (sellFeeStep < 11) {
                uint256 addSellFee = 220;
                if (block.timestamp - _initRebaseStartTime > 3600 * 24 * sellFeeStep) {
                    addSellFee = 220 - (20 * sellFeeStep);
                    sellFeeStep++;
                }
                _totalFee = totalFee.add(addSellFee).add(sellFee).add(nftFee);
                _liquidityFee = liquidityFee.add(sellFee);
                _nftFee = nftFee.add(addSellFee);
            }
	        else {
                _totalFee = totalFee.add(sellFee).add(nftFee);
                _liquidityFee = liquidityFee.add(sellFee);
                _nftFee = nftFee;
	        }
        }

        uint256 feeAmount = gonAmount.div(feeDenominator).mul(_totalFee);
       
        _gonBalances[blackhole] = _gonBalances[blackhole].add(
            gonAmount.div(feeDenominator).mul(blackholeFee)
        );
        _gonBalances[address(this)] = _gonBalances[address(this)].add(
            gonAmount.div(feeDenominator).mul(treasuryFee.add(smartInsuranceFundFee))
        );
        _gonBalances[autoLiquidityReceiver] = _gonBalances[autoLiquidityReceiver].add(
            gonAmount.div(feeDenominator).mul(_liquidityFee)
        );
        _gonBalances[nftFeeReceiver] = _gonBalances[nftFeeReceiver].add(
            gonAmount.div(feeDenominator).mul(_nftFee)
        );
        
        emit Transfer(sender, address(this), feeAmount.div(_gonsPerFragment));
        return gonAmount.sub(feeAmount);
    }

    function addLiquidity() internal swapping {
        uint256 autoLiquidityAmount = _gonBalances[autoLiquidityReceiver].div(
            _gonsPerFragment
        );
        _gonBalances[address(this)] = _gonBalances[address(this)].add(
            _gonBalances[autoLiquidityReceiver]
        );
        _gonBalances[autoLiquidityReceiver] = 0;
        uint256 amountToLiquify = autoLiquidityAmount.div(2);
        uint256 amountToSwap = autoLiquidityAmount.sub(amountToLiquify);

        if( amountToSwap == 0 ) {
            return;
        }
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = WAVAX;

        uint256 balanceBefore = IERC20(WAVAX).balanceOf(address(this));

        router.swapExactTokensForTokensSupportingFeeOnTransferTokens(
            amountToSwap,
            0,
            path,
            wavaxReceiver,
            block.timestamp
        );

        IWAVAXReceiver(wavaxReceiver).withdraw();

        uint256 amountWAVAXLiquidity = IERC20(WAVAX).balanceOf(address(this)).sub(balanceBefore);

        IERC20(WAVAX).approve(0x60aE616a2155Ee3d9A68541Ba4544862310933d4, amountWAVAXLiquidity);

        if (amountToLiquify > 0 && amountWAVAXLiquidity > 0) {
            router.addLiquidity(
                address(this),
                WAVAX,
                amountToLiquify,
                amountWAVAXLiquidity,
                0,
                0,
                pair,
                block.timestamp
            );
        }
        _lastAddLiquidityTime = block.timestamp;
    }

    function swapBack() internal swapping {

        uint256 amountToSwap = _gonBalances[address(this)].div(_gonsPerFragment);

        if( amountToSwap == 0) {
            return;
        }

        uint256 balanceBefore = IERC20(WAVAX).balanceOf(address(this));
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = WAVAX;

        
        router.swapExactTokensForTokensSupportingFeeOnTransferTokens(
            amountToSwap,
            0,
            path,
            wavaxReceiver,
            block.timestamp
        );

        IWAVAXReceiver(wavaxReceiver).withdraw();

        uint256 amountWAVAXToTreasuryAndAIF = IERC20(WAVAX).balanceOf(address(this)).sub(balanceBefore);

        IERC20(WAVAX).transfer(treasuryReceiver, amountWAVAXToTreasuryAndAIF.mul(treasuryFee).div(treasuryFee.add(smartInsuranceFundFee)));
        IERC20(WAVAX).transfer(smartInsuranceFundReceiver, amountWAVAXToTreasuryAndAIF.mul(smartInsuranceFundFee).div(treasuryFee.add(smartInsuranceFundFee)));
    }

    function withdrawAllToTreasury() external swapping onlyOwner {

        uint256 amountToSwap = _gonBalances[address(this)].div(_gonsPerFragment);
        require( amountToSwap > 0,"There is no SMART token deposited in token contract");
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = WAVAX;
        router.swapExactTokensForTokensSupportingFeeOnTransferTokens(
            amountToSwap,
            0,
            path,
            treasuryReceiver,
            block.timestamp
        );
    }

    function shouldTakeFee(address from, address to)
        internal
        view
        returns (bool)
    {
        return 
            (pair == from || pair == to) &&
            !_isFeeExempt[from];
    }

    function shouldRebase() internal view returns (bool) {
        return
            _autoRebase &&
            (_totalSupply < MAX_SUPPLY) &&
            msg.sender != pair  &&
            !inSwap &&
            block.timestamp >= (_lastRebasedTime + 15 minutes);
    }

    function shouldAddLiquidity() internal view returns (bool) {
        return
            _autoAddLiquidity && 
            !inSwap && 
            msg.sender != pair &&
            block.timestamp >= (_lastAddLiquidityTime + 8 hours);
    }

    function shouldSwapBack() internal view returns (bool) {
        return 
            !inSwap &&
            msg.sender != pair  ; 
    }

    function setAutoRebase(bool _flag) external onlyOwner {
        if (_flag) {
            _autoRebase = _flag;
            _lastRebasedTime = block.timestamp;
        } else {
            _autoRebase = _flag;
        }
    }

    function setAutoAddLiquidity(bool _flag) external onlyOwner {
        if(_flag) {
            _autoAddLiquidity = _flag;
            _lastAddLiquidityTime = block.timestamp;
        } else {
            _autoAddLiquidity = _flag;
        }
    }

    function toggleSwap() public onlyOwner {
        swapEnabled = true;
        emit SwapEnabled();
    }


    function allowance(address owner_, address spender)
        external
        view
        override
        returns (uint256)
    {
        return _allowedFragments[owner_][spender];
    }

    function decreaseAllowance(address spender, uint256 subtractedValue)
        external
        returns (bool)
    {
        uint256 oldValue = _allowedFragments[msg.sender][spender];
        if (subtractedValue >= oldValue) {
            _allowedFragments[msg.sender][spender] = 0;
        } else {
            _allowedFragments[msg.sender][spender] = oldValue.sub(
                subtractedValue
            );
        }
        emit Approval(
            msg.sender,
            spender,
            _allowedFragments[msg.sender][spender]
        );
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue)
        external
        returns (bool)
    {
        _allowedFragments[msg.sender][spender] = _allowedFragments[msg.sender][
            spender
        ].add(addedValue);
        emit Approval(
            msg.sender,
            spender,
            _allowedFragments[msg.sender][spender]
        );
        return true;
    }

    function approve(address spender, uint256 value)
        external
        override
        returns (bool)
    {
        _allowedFragments[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function checkFeeExempt(address _addr) external view returns (bool) {
        return _isFeeExempt[_addr];
    }

    function getCirculatingSupply() public view returns (uint256) {
        return
            (TOTAL_GONS.sub(_gonBalances[DEAD]).sub(_gonBalances[ZERO])).sub(_gonBalances[blackhole]).div(
                _gonsPerFragment
            );
    }

    function getCurrentDay() public view returns (uint256) {
        return minZero(block.timestamp, startTime).div(TIME_STEP);
    }

    function getUserHoldLimit() public view returns (uint256) {
        return getCirculatingSupply().mul(holdLimit).div(limitDenominator);
    }

    function getUserSellLimit() public view returns (uint256) {
        return getCirculatingSupply().mul(sellLimit).div(limitDenominator);
    }

    function isNotInSwap() external view returns (bool) {
        return !inSwap;
    }

    function manualSync() external {
        IPancakeSwapPair(pair).sync();
    }

    function setFeeReceivers(
        address _autoLiquidityReceiver,
        address _treasuryReceiver,
        address _smartInsuranceFundReceiver,
        address _blackhole
    ) external onlyOwner {
        autoLiquidityReceiver = _autoLiquidityReceiver;
        treasuryReceiver = _treasuryReceiver;
        smartInsuranceFundReceiver = _smartInsuranceFundReceiver;
        blackhole = _blackhole;
    }

    function setNFTFeeReceivers(address _nftFeeReceiver) external {
        require(msg.sender == nftFeeReceiver, '!fee');
        require(_nftFeeReceiver != address(0), "zero");
        nftFeeReceiver = _nftFeeReceiver;
    }

    function getLiquidityBacking(uint256 accuracy)
        public
        view
        returns (uint256)
    {
        uint256 liquidityBalance = _gonBalances[pair].div(_gonsPerFragment);
        return
            accuracy.mul(liquidityBalance.mul(2)).div(getCirculatingSupply());
    }

    function setWhitelist(address _addr) external onlyOwner {
        _isFeeExempt[_addr] = true;
    }

    function setBotBlacklist(address _botAddress, bool _flag) external onlyOwner {
        require(isContract(_botAddress), "Only contract address, not allowed exteranlly owned account");
        blacklist[_botAddress] = _flag;    
    }
    
    function setPairAddress(address _pairAddress) public onlyOwner {
        pairAddress = _pairAddress;
    }

    function setLP(address _address) external onlyOwner {
        pairContract = IPancakeSwapPair(_address);
    }

    function setExcludeFromLimit(address _address, bool _bool) public onlyOwner {
        _excludeFromLimit[_address] = _bool;
    }

    function setLimit(uint256 _holdLimit, uint256 _sellLimit) public onlyOwner {
        require(_holdLimit >= 5 && _holdLimit <= 10000, "Invalid hold limit");
        require(_sellLimit >= 5 && _sellLimit <= 10000, "Invalid sell limit");
        holdLimit = _holdLimit;
        sellLimit = _sellLimit;
    }
    
    function setLaunchDate(uint256 initrebaseStartTime, uint256 initRebaseTime) public onlyOwner {
        require(block.timestamp < _initRebaseStartTime && block.timestamp < _lastRebasedTime, "Already rebase started");
            _initRebaseStartTime = initrebaseStartTime;
            _lastRebasedTime = initRebaseTime;
    }

    function totalSupply() external view override returns (uint256) {
        return _totalSupply;
    }
   
    function balanceOf(address who) external view override returns (uint256) {
        return _gonBalances[who].div(_gonsPerFragment);
    }

    function isContract(address addr) internal view returns (bool) {
        uint size;
        assembly { size := extcodesize(addr) }
        return size > 0;
    }

    function setSellFeeStep(uint _sellFeeStep) external onlyOwner {
        require( block.timestamp < _initRebaseStartTime, "Already rebase started");
        require( _sellFeeStep < 12, "Cann't be greater than 12");
        sellFeeStep = _sellFeeStep;
    }

    function minZero(uint a, uint b) private pure returns(uint) {
        if (a > b) {
           return a - b; 
        } else {
           return 0;    
        }    
    }   

    receive() external payable {}
}
