Return-Path: <SRS0=ZIWc=3C=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17109C33CAE
	for <linux-rtc@archiver.kernel.org>; Mon, 13 Jan 2020 06:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7255214D8
	for <linux-rtc@archiver.kernel.org>; Mon, 13 Jan 2020 06:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387432AbgAMGmw (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 13 Jan 2020 01:42:52 -0500
Received: from smtprelay0191.hostedemail.com ([216.40.44.191]:60821 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732311AbgAMGmq (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 13 Jan 2020 01:42:46 -0500
X-Greylist: delayed 349 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Jan 2020 01:42:46 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id A06851801D3EC
        for <linux-rtc@vger.kernel.org>; Mon, 13 Jan 2020 06:36:57 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 0DBB9100E7B43;
        Mon, 13 Jan 2020 06:36:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sail11_3c6014f468a37
X-Filterd-Recvd-Size: 2927
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Mon, 13 Jan 2020 06:36:54 +0000 (UTC)
Message-ID: <9286d81a883f4795176182fdb9e69bc19a8232c7.camel@perches.com>
Subject: Re: [PATCH] rtc: i2c/spi: Avoid inclusion of REGMAP support when
 not needed
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 12 Jan 2020 22:36:00 -0800
In-Reply-To: <20200112171349.22268-1-geert@linux-m68k.org>
References: <20200112171349.22268-1-geert@linux-m68k.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Sun, 2020-01-12 at 18:13 +0100, Geert Uytterhoeven wrote:
> Merely enabling I2C and RTC selects REGMAP_I2C and REGMAP_SPI, even when
> no driver needs it.  While the former can be moduler, the latter cannot,
> and thus becomes built-in.
> 
> Fix this by moving the select statements for REGMAP_I2C and REGMAP_SPI
> from the RTC_I2C_AND_SPI helper to the individual drivers that depend on
> it.
> 
> Note that the comment for RTC_I2C_AND_SPI refers to SND_SOC_I2C_AND_SPI
> for more information, but the latter does not select REGMAP_{I2C,SPI}
> itself, and defers that to the individual drivers, too.
> 
> Fixes: 080481f54ef62121 ("rtc: merge ds3232 and ds3234")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Joe: When merging addresses, scripts/get_maintainer.pl replaces
>      Alexandre's authoritative email address from MAINTAINERS by the
>      obsolete address in the SoB-line of the commit referred to by the
>      Fixes-line.

Hi Geert

What are you doing to get this changed output?

I get the same get_maintainer address output either way
with only with the 'blamed_fixes:' content added.

Your email with 'Fixes:' line:

$ ./scripts/get_maintainer.pl ~/geert_1.mbox 
Alessandro Zummo <a.zummo@towertech.it> (maintainer:REAL TIME CLOCK (RTC) SUBSYSTEM)
Alexandre Belloni <alexandre.belloni@bootlin.com> (maintainer:REAL TIME CLOCK (RTC) SUBSYSTEM,blamed_fixes:1/1=100%)
Akinobu Mita <akinobu.mita@gmail.com> (blamed_fixes:1/1=100%)
linux-rtc@vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)

Your email without 'Fixes:' line:

$ ./scripts/get_maintainer.pl ~/geert_2.mbox 
Alessandro Zummo <a.zummo@towertech.it> (maintainer:REAL TIME CLOCK (RTC) SUBSYSTEM)
Alexandre Belloni <alexandre.belloni@bootlin.com> (maintainer:REAL TIME CLOCK (RTC) SUBSYSTEM)
linux-rtc@vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)



