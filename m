Return-Path: <SRS0=y2Nk=M3=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B79C04AA5
	for <linux-rtc@archiver.kernel.org>; Mon, 15 Oct 2018 12:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248212064A
	for <linux-rtc@archiver.kernel.org>; Mon, 15 Oct 2018 12:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248212064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbeJOUZH (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:25:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39246 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbeJOUZH (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 15 Oct 2018 16:25:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E16FF2074F; Mon, 15 Oct 2018 14:39:56 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id B514E20379;
        Mon, 15 Oct 2018 14:39:56 +0200 (CEST)
Date:   Mon, 15 Oct 2018 14:39:58 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Craig McQueen <craig.mcqueen@innerrange.com>
Cc:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
Subject: Re: rtc-pcf85063 driver bug in pcf85063_stop_clock()
Message-ID: <20181015123958.GE17341@piout.net>
References: <7f8c164eb0fd47788ec6bbd34735f4a5@innerrange.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f8c164eb0fd47788ec6bbd34735f4a5@innerrange.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hello,

On 11/10/2018 06:53:15+0000, Craig McQueen wrote:
> The function pcf85063_stop_clock() is intended to provide the value of the Control_1 register via the pointer ctrl1.
> 
> However, it's really providing the return value of the last i2c_smbus_write_byte_data() call, i.e., zero. So the register value needs to be saved in a separate local variable other than ret. Or, the line *ctrl1 = ret; needs to be moved up to be above the last i2c_smbus_write_byte_data() call.
> 

Isn't that fixed by http://patchwork.ozlabs.org/patch/944107/ ?

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
