Return-Path: <SRS0=Bgbz=SR=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9DCC10F0E
	for <linux-rtc@archiver.kernel.org>; Mon, 15 Apr 2019 15:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75C02075B
	for <linux-rtc@archiver.kernel.org>; Mon, 15 Apr 2019 15:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfDOPer (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:34:47 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:49803 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfDOPer (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 15 Apr 2019 11:34:47 -0400
X-Originating-IP: 109.212.207.226
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 8077740007;
        Mon, 15 Apr 2019 15:34:45 +0000 (UTC)
Date:   Mon, 15 Apr 2019 17:34:45 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mastro Gippo <gipmad@gmail.com>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org
Subject: Re: Infinite loop on edge cases
Message-ID: <20190415153444.GI3578@piout.net>
References: <CADjOgT97-8PM1=Nm+Mk4jw_8vzt3i9KXUohDAkUsptxS7JuU6Q@mail.gmail.com>
 <20190409090119.GT7480@piout.net>
 <CADjOgT-BK2SyoZD76iLj-fYG-7-2G0SvkFC4M6zakQc+7Q3g_w@mail.gmail.com>
 <20190409112754.GU7480@piout.net>
 <CADjOgT8-C+6WO0Y9c2bDJJhTcpMkKozcru0SuWOEO_Xa6v5hyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADjOgT8-C+6WO0Y9c2bDJJhTcpMkKozcru0SuWOEO_Xa6v5hyg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi,

On 09/04/2019 16:35:29+0200, Mastro Gippo wrote:
> Thanks Alexandre, let me know if you need help testing the patches
> when they're available.
> I can "simulate" various failure modes on my hardware.

Did you have a chance to test the patch I sent?


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
