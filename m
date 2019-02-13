Return-Path: <SRS0=hLTa=QU=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BIGNUM_EMAILS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCACC282C2
	for <linux-rtc@archiver.kernel.org>; Wed, 13 Feb 2019 17:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CF62086C
	for <linux-rtc@archiver.kernel.org>; Wed, 13 Feb 2019 17:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387572AbfBMRv2 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:51:28 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37895 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387546AbfBMRv2 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 13 Feb 2019 12:51:28 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gtygw-0001Wi-KU; Wed, 13 Feb 2019 18:51:26 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gtygv-0007uQ-UJ; Wed, 13 Feb 2019 18:51:25 +0100
Date:   Wed, 13 Feb 2019 18:51:25 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-rtc@vger.kernel.org
Subject: Re: [bug report] rtc: ds1307: rx8130: honor Voltage Loss Flag when
 reading the time
Message-ID: <20190213175125.bpwwi2slm6lvjg3x@pengutronix.de>
References: <20190213131731.GA29774@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190213131731.GA29774@kadam>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rtc@vger.kernel.org
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hello Dan,

On Wed, Feb 13, 2019 at 04:17:31PM +0300, Dan Carpenter wrote:
> The patch 501f98266cad: "rtc: ds1307: rx8130: honor Voltage Loss Flag
> when reading the time" from Jan 25, 2019, leads to the following
> static checker warning:
> 
> 	drivers/rtc/rtc-ds1307.c:314 ds1307_set_time()
> 	warn: this cast is a no-op
> 
> drivers/rtc/rtc-ds1307.c
>     304 	result = regmap_bulk_write(ds1307->regmap, chip->offset, regs,
>     305 				   sizeof(regs));
>     306 	if (result) {
>     307 		dev_err(dev, "%s error %d\n", "write", result);
>     308 		return result;
>     309 	}
>     310 
>     311 	if (ds1307->type == rx_8130) {
>     312 		/* clear Voltage Loss Flag as data is available now */
>     313 		result = regmap_write(ds1307->regmap, RX8130_REG_FLAG,
> --> 314 				      ~(u8)RX8130_REG_FLAG_VLF);
>                                                ^^^^^^^^^^^^^^^^^^^^^^^^
> RX8130_REG_FLAG_VLF is 0x2.  The cast to u8 doesn't change anything
> because it gets type promoted to int.  I don't know what was intended.

This reasoning looks right, yes. I don't remember why I added it.
Probably because I intended to create the value 0xfd and not 0xfffffffd
(aka -3).

Feel free to fix this in a patch blaming me.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
