/*
 * Copyright (c) 20022 The CoinUA Core developers
 * Distributed under the MIT software license, see the accompanying
 * file COPYING or http://www.opensource.org/licenses/mit-license.php.
 */

#ifndef SRC_FOUNDER_PAYMENT_H_
#define SRC_FOUNDER_PAYMENT_H_
#include <string>
#include <amount.h>
#include <primitives/transaction.h>
#include <script/standard.h>
#include <limits.h>
using namespace std;

static const string DEFAULT_FOUNDER_ADDRESS = "";
struct FounderRewardStructure {
	int blockHeight;
	int rewardPercentage;
};

class FounderPayment {
public:
	FounderPayment(vector<FounderRewardStructure> rewardStructures = {}, int startBlock = 0, const string &address = DEFAULT_FOUNDER_ADDRESS, const bool enable = false) {
		this->founderAddress = address;
		this->startBlock = startBlock;
        this->feeEnabled = enable;
		this->rewardStructures = rewardStructures;
	}
	~FounderPayment(){};
	CAmount getFounderPaymentAmount(int blockHeight, CAmount blockReward);
	void FillFounderPayment(CMutableTransaction& txNew, int nBlockHeight, CAmount blockReward, CTxOut& txoutFounderRet);
	bool IsBlockPayeeValid(const CTransaction& txNew, const int height, const CAmount blockReward);
	int getStartBlock() {return this->startBlock;}
    bool isEnable() {return this->feeEnabled;}
private:
	string founderAddress;
	int startBlock;
    bool feeEnabled;
	vector<FounderRewardStructure> rewardStructures;
};



#endif /* SRC_FOUNDER_PAYMENT_H_ */
