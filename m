Return-Path: <SRS0=PR+X=7J=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFE3C433E0
	for <linux-rtc@archiver.kernel.org>; Wed, 27 May 2020 23:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE3B6207D3
	for <linux-rtc@archiver.kernel.org>; Wed, 27 May 2020 23:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgE0XGs (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 27 May 2020 19:06:48 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:34361 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0XGs (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 27 May 2020 19:06:48 -0400
X-Originating-IP: 86.202.110.81
Received: from localhost (lfbn-lyo-1-15-81.w86-202.abo.wanadoo.fr [86.202.110.81])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 67FE6FF804;
        Wed, 27 May 2020 23:06:46 +0000 (UTC)
Date:   Thu, 28 May 2020 01:06:46 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Igor Plyatov <plyatov@gmail.com>
Cc:     linux-rtc@vger.kernel.org
Subject: Re: Automatical handling of /sys/class/rtc/rtcN/offset
Message-ID: <20200527230646.GN3972@piout.net>
References: <810d81d9-847d-a849-bf8e-49ea59ba6b83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <810d81d9-847d-a849-bf8e-49ea59ba6b83@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi,

On 26/05/2020 21:57:50+0300, Igor Plyatov wrote:
> I have found that my RTC  (M41T00) is capable to make precise compensation
> of offset in the Control register.
> 
> Its driver, rtc-ds1307.c has support for such offset compensation and
> provide the /sys/class/rtc/rtc0/offset file.
> 
> Compensation tested and operate as expected, when I manually read/write
> offset value (in PPB) from/into the /sys/class/rtc/rtc0/offset file.
> 
> Does handling of such RTC offset already automatized somehow instead of
> doing this manually?
> 

No, my plan was to add support for that in chrony. chrony is already
able to calculate the correct offset but it doesn't make use of it for
the moment.

What are you using to calculate the offset?

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
