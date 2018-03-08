Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from gateway34.websitewelcome.com ([192.185.149.101]:16655 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754996AbeCHDnV (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 7 Mar 2018 22:43:21 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 7B678691106
        for <linux-rtc@vger.kernel.org>; Wed,  7 Mar 2018 21:18:42 -0600 (CST)
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [RFC] Removing VLAs in rtc-s5m
Message-ID: <82561e18-2283-897a-49b9-9606e3b7e1b2@embeddedor.com>
Date: Wed, 7 Mar 2018 21:18:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Alexandre,

I'm trying to figure out the best way to fix the following VLA warnings:

drivers/rtc/rtc-s5m.c:370:2: warning: ISO C90 forbids variable length 
array ‘data’ [-Wvla]
drivers/rtc/rtc-s5m.c:416:2: warning: ISO C90 forbids variable length 
array ‘data’ [-Wvla]
drivers/rtc/rtc-s5m.c:453:2: warning: ISO C90 forbids variable length 
array ‘data’ [-Wvla]
drivers/rtc/rtc-s5m.c:503:2: warning: ISO C90 forbids variable length 
array ‘data’ [-Wvla]
drivers/rtc/rtc-s5m.c:548:2: warning: ISO C90 forbids variable length 
array ‘data’ [-Wvla]
drivers/rtc/rtc-s5m.c:601:2: warning: ISO C90 forbids variable length 
array ‘data’ [-Wvla]


So I took a look into the following piece of code at 
drivers/rtc/rtc-s5m.c:31, please see my comments below.

/*
  * Registers used by the driver which are different between chipsets.
  *
  * Operations like read time and write alarm/time require updating
  * specific fields in UDR register. These fields usually are auto-cleared
  * (with some exceptions).
  *
  * Table of operations per device:
  *
  * Device     | Write time | Read time | Write alarm
  * =================================================
  * S5M8767    | UDR + TIME |           | UDR
  * S2MPS11/14 | WUDR       | RUDR      | WUDR + RUDR
  * S2MPS13    | WUDR       | RUDR      | WUDR + AUDR
  * S2MPS15    | WUDR       | RUDR      | AUDR
  */
struct s5m_rtc_reg_config {
	/* Number of registers used for setting time/alarm0/alarm1 */
	unsigned int regs_count;


Once the maximum number of registers for devices S5M8767, S2MPS11/14 
S2MPS13 and S2MPS15 are 8, 7, 7 and 7 correspondingly, I think we can 
safely change the type of regs_count to u8/uint8_t. And then define a 
macro like the following:

#define MAX_NUM_REGS 8 or 10

so we can replace this kind of code:

u8 data[info->regs->regs_count];

with this:

u8 data[MAX_NUM_REGS];

What do you think?

Is there any chance a new device of this kind with more than 10 or 15 
registers can be added in the future?


	/* First register for time, seconds */
	unsigned int time;
	/* RTC control register */
	unsigned int ctrl;
	/* First register for alarm 0, seconds */
	unsigned int alarm0;
	/* First register for alarm 1, seconds */
	unsigned int alarm1;
	/*
	 * Register for update flag (UDR). Typically setting UDR field to 1
	 * will enable update of time or alarm register. Then it will be
	 * auto-cleared after successful update.
	 */
	unsigned int udr_update;
	/* Auto-cleared mask in UDR field for writing time and alarm */
	unsigned int autoclear_udr_mask;
	/*
	 * Masks in UDR field for time and alarm operations.
	 * The read time mask can be 0. Rest should not.
	 */
	unsigned int read_time_udr_mask;
	unsigned int write_time_udr_mask;
	unsigned int write_alarm_udr_mask;
};

/* Register map for S5M8763 and S5M8767 */
static const struct s5m_rtc_reg_config s5m_rtc_regs = {
	.regs_count		= 8,
	.time			= S5M_RTC_SEC,
	.ctrl			= S5M_ALARM1_CONF,
	.alarm0			= S5M_ALARM0_SEC,
	.alarm1			= S5M_ALARM1_SEC,
	.udr_update		= S5M_RTC_UDR_CON,
	.autoclear_udr_mask	= S5M_RTC_UDR_MASK,
	.read_time_udr_mask	= 0, /* Not needed */
	.write_time_udr_mask	= S5M_RTC_UDR_MASK | S5M_RTC_TIME_EN_MASK,
	.write_alarm_udr_mask	= S5M_RTC_UDR_MASK,
};

/* Register map for S2MPS13 */
static const struct s5m_rtc_reg_config s2mps13_rtc_regs = {
	.regs_count		= 7,
	.time			= S2MPS_RTC_SEC,
	.ctrl			= S2MPS_RTC_CTRL,
	.alarm0			= S2MPS_ALARM0_SEC,
	.alarm1			= S2MPS_ALARM1_SEC,
	.udr_update		= S2MPS_RTC_UDR_CON,
	.autoclear_udr_mask	= S2MPS_RTC_WUDR_MASK,
	.read_time_udr_mask	= S2MPS_RTC_RUDR_MASK,
	.write_time_udr_mask	= S2MPS_RTC_WUDR_MASK,
	.write_alarm_udr_mask	= S2MPS_RTC_WUDR_MASK | S2MPS13_RTC_AUDR_MASK,
};

/* Register map for S2MPS11/14 */
static const struct s5m_rtc_reg_config s2mps14_rtc_regs = {
	.regs_count		= 7,
	.time			= S2MPS_RTC_SEC,
	.ctrl			= S2MPS_RTC_CTRL,
	.alarm0			= S2MPS_ALARM0_SEC,
	.alarm1			= S2MPS_ALARM1_SEC,
	.udr_update		= S2MPS_RTC_UDR_CON,
	.autoclear_udr_mask	= S2MPS_RTC_WUDR_MASK,
	.read_time_udr_mask	= S2MPS_RTC_RUDR_MASK,
	.write_time_udr_mask	= S2MPS_RTC_WUDR_MASK,
	.write_alarm_udr_mask	= S2MPS_RTC_WUDR_MASK | S2MPS_RTC_RUDR_MASK,
};

/*
  * Register map for S2MPS15 - in comparison to S2MPS14 the WUDR and 
AUDR bits
  * are swapped.
  */
static const struct s5m_rtc_reg_config s2mps15_rtc_regs = {
	.regs_count		= 7,
	.time			= S2MPS_RTC_SEC,
	.ctrl			= S2MPS_RTC_CTRL,
	.alarm0			= S2MPS_ALARM0_SEC,
	.alarm1			= S2MPS_ALARM1_SEC,
	.udr_update		= S2MPS_RTC_UDR_CON,
	.autoclear_udr_mask	= S2MPS_RTC_WUDR_MASK,
	.read_time_udr_mask	= S2MPS_RTC_RUDR_MASK,
	.write_time_udr_mask	= S2MPS15_RTC_WUDR_MASK,
	.write_alarm_udr_mask	= S2MPS15_RTC_AUDR_MASK,
};

Thanks
--
Gustavo
