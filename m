Return-Path: <SRS0=ZSCd=SL=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=BIGNUM_EMAILS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8B2C282DA
	for <linux-rtc@archiver.kernel.org>; Tue,  9 Apr 2019 14:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD80C208C0
	for <linux-rtc@archiver.kernel.org>; Tue,  9 Apr 2019 14:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfDIOn3 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:43:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:5695 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbfDIOn2 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 9 Apr 2019 10:43:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 07:43:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,329,1549958400"; 
   d="scan'208";a="335195453"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga006.fm.intel.com with ESMTP; 09 Apr 2019 07:43:27 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hDryA-0004Np-Qp; Tue, 09 Apr 2019 17:43:26 +0300
Date:   Tue, 9 Apr 2019 17:43:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-rtc@vger.kernel.org
Subject: Re: [bug report] rtc: rx8025: Switch to use %ptR
Message-ID: <20190409144326.GN9224@smile.fi.intel.com>
References: <20190409114911.GA16122@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409114911.GA16122@kadam>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Tue, Apr 09, 2019 at 02:49:11PM +0300, Dan Carpenter wrote:
> Hello Andy Shevchenko,
> 
> The patch 1921cab11723: "rtc: rx8025: Switch to use %ptR" from Dec 4,
> 2018, leads to the following static checker warning:
> 
> 	drivers/rtc/rtc-rx8025.c:314 rx8025_read_alarm()
> 	error: '%ptR' expects argument of type struct 'rtc_time', argument 5 has type 'struct rtc_wkalrm*'
> 
> drivers/rtc/rtc-rx8025.c
>     284 static int rx8025_read_alarm(struct device *dev, struct rtc_wkalrm *t)
>                                                          ^^^^^^^^^^^^^^^^^^^^
> 
>     285 {
>     286 	struct rx8025_data *rx8025 = dev_get_drvdata(dev);
>     287 	struct i2c_client *client = rx8025->client;
>     288 	u8 ald[2];
>     289 	int ctrl2, err;
>     290 
>     291 	if (client->irq <= 0)
>     292 		return -EINVAL;
>     293 
>     294 	err = rx8025_read_regs(client, RX8025_REG_ALDMIN, 2, ald);
>     295 	if (err)
>     296 		return err;
>     297 
>     298 	ctrl2 = rx8025_read_reg(client, RX8025_REG_CTRL2);
>     299 	if (ctrl2 < 0)
>     300 		return ctrl2;
>     301 
>     302 	dev_dbg(dev, "%s: read alarm 0x%02x 0x%02x ctrl2 %02x\n",
>     303 		__func__, ald[0], ald[1], ctrl2);
>     304 
>     305 	/* Hardware alarms precision is 1 minute! */
>     306 	t->time.tm_sec = 0;
>     307 	t->time.tm_min = bcd2bin(ald[0] & 0x7f);
>     308 	if (rx8025->ctrl1 & RX8025_BIT_CTRL1_1224)
>     309 		t->time.tm_hour = bcd2bin(ald[1] & 0x3f);
>     310 	else
>     311 		t->time.tm_hour = bcd2bin(ald[1] & 0x1f) % 12
>     312 			+ (ald[1] & 0x20 ? 12 : 0);
>     313 
> --> 314 	dev_dbg(dev, "%s: date: %ptRr\n", __func__, t);
>                                         ^^^^^               ^
> You mean t->time?

Looks more like pointer to t->time, but yes, the current is using a wrong type.

> 
>     315 	t->enabled = !!(rx8025->ctrl1 & RX8025_BIT_CTRL1_DALE);
>     316 	t->pending = (ctrl2 & RX8025_BIT_CTRL2_DAFG) && t->enabled;
>     317 
>     318 	return err;
>     319 }
> 
> regards,
> dan carpenter

-- 
With Best Regards,
Andy Shevchenko


