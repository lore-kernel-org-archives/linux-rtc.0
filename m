Return-Path: <SRS0=HQnH=EM=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46687C2D0A3
	for <linux-rtc@archiver.kernel.org>; Fri,  6 Nov 2020 08:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D48E3206D9
	for <linux-rtc@archiver.kernel.org>; Fri,  6 Nov 2020 08:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgKFIDA (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 6 Nov 2020 03:03:00 -0500
Received: from goliath.siemens.de ([192.35.17.28]:57246 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgKFIDA (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 6 Nov 2020 03:03:00 -0500
X-Greylist: delayed 1334 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Nov 2020 03:02:58 EST
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 0A67eZj0022080
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Nov 2020 08:40:35 +0100
Received: from md1za8fc.ad001.siemens.net ([139.22.116.104])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 0A67eZ1W031851;
        Fri, 6 Nov 2020 08:40:35 +0100
Date:   Fri, 6 Nov 2020 08:40:34 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Claudius Heine <ch@denx.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Johannes Hahn <johannes-hahn@siemens.com>,
        werner.zeh@siemens.com
Subject: Re: [PATCH 0/2]  Adding I2C support to RX6110 RTC
Message-ID: <20201106084034.0ea09ea3@md1za8fc.ad001.siemens.net>
In-Reply-To: <20201105221451.GH1034841@piout.net>
References: <20201104102629.3422048-1-ch@denx.de>
        <20201105221451.GH1034841@piout.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi,

Am Thu, 5 Nov 2020 23:14:51 +0100
schrieb Alexandre Belloni <alexandre.belloni@bootlin.com>:

> Hello Claudius!
> 
> It has been a while ;)
> 
> On 04/11/2020 11:26:27+0100, Claudius Heine wrote:
> > Hi,
> > 
> > this patch introduces I2C support to the RX6110 RTC driver and also
> > adds an ACPI identifier to it.
> > 
> > Since we are also pushing the coreboot changes for the ACPI table
> > upstream in parallel, we are free to name this ACPI entry however we
> > like it seems. So any feedback on that would be welcome ;)
> >   
> 
> I don't care too much about ACPI so if you are really looking for
> advice there, I guess you should ask seom of the ACPI guys (but I
> guess you are free to choose whatever you want).
> 

This is the coreboot stuff currently under review.

https://review.coreboot.org/c/coreboot/+/47235

Henning
