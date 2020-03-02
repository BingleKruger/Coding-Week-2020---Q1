const truffleAssert = require('truffle-assertions')
// import the contract artifact
const CoShoe = artifacts.require('./CoShoe.sol')

// test starts here
contract('CoShoe', function (accounts) {
    // predefine the contract instance
    let CoShoeInstance

    // before each test, create a new contract instance
    beforeEach(async function () {
        CoShoeInstance = await CoShoe.new()
    })

    // first test:
    it('Should mint 100 tokens on deployment', async function () {
        let supply = await CoShoeInstance.totalSupply()
        assert.equal(supply.toNumber(), 20, "Problem minting CoShoe tokens")
    })

    // second test:
    it('buyShoe correctly transfers ownership, sets the name and the image, sets sold, and updates soldShoes count', async function () {
        await CoShoeInstance.buyShoe("Bingle", "bingle.com/coolpicture.jpg", { from: accounts[1], value: web3.utils.toWei('0.5', 'ether') })
        let _shoes = await CoShoeInstance.shoes(0)
        let _soldShoes = await CoShoeInstance.numberShoesSold()
        assert.equal(_shoes['owner'], accounts[1], "Problem with transferring ownership")
        assert.equal(_shoes['name'], "Bingle", "Problem with setting the name")
        assert.equal(_shoes['image'], "bingle.com/coolpicture.jpg", "Problem with setting the image")
        assert.equal(_shoes['sold'], true, "Problem with setting sold bool")
        assert.equal(_soldShoes, 1, "Problem updating soldShoes count")
    })

    // third test
    it('buyShoe reverts if price is not equal to 0.5 ether', async function () {
        await truffleAssert.reverts(CoShoeInstance.buyShoe("Bingle", "bingle.com/coolpicture.jpg", { from: accounts[1], value: web3.utils.toWei('0.4', 'ether') }))
    })


})