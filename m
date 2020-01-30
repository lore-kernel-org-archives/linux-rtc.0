Return-Path: <SRS0=SyWM=3T=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22D0C33C9E
	for <linux-rtc@archiver.kernel.org>; Thu, 30 Jan 2020 10:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDF9206D3
	for <linux-rtc@archiver.kernel.org>; Thu, 30 Jan 2020 10:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgA3Kr6 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:47:58 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:45373 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3Kr6 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 30 Jan 2020 05:47:58 -0500
X-Originating-IP: 90.65.102.129
Received: from localhost (lfbn-lyo-1-1670-129.w90-65.abo.wanadoo.fr [90.65.102.129])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 610DCE0006;
        Thu, 30 Jan 2020 10:47:56 +0000 (UTC)
Date:   Thu, 30 Jan 2020 11:47:56 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     JH <jupiter.hce@gmail.com>
Cc:     linux-rtc@vger.kernel.org
Subject: Re: rtc rtc0: Timeout trying to get valid LPSRT Counter read
Message-ID: <20200130104756.GC3583@piout.net>
References: <CAA=hcWQcVi79AW9aOSGQSzEwL-sPwvt=4zR+_25mJKvbkBON1w@mail.gmail.com>
 <20200112110353.GC1253990@piout.net>
 <CAA=hcWQoY95oPbLYyD306_wxmj=GU57t8m-m_kWwyy5-7Quj=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA=hcWQoY95oPbLYyD306_wxmj=GU57t8m-m_kWwyy5-7Quj=Q@mail.gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 30/01/2020 13:36:26+1100, JH wrote:
> Hi Alexandre,
> 
> Thanks for your response.
> 
> On 1/12/20, Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> > Hi,
> >
> > On 02/01/2020 19:40:10+1100, JH wrote:
> >> Hi,
> >>
> >> I am running kernel 4.19 on imx6, could anyone help for clues what
> >> that error is about? What I could be missing and how to fix it?
> >>
> >
> > I'd say that you have an issue with the 32k clock or tamper detection,
> > have a look at this commit:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cd7f3a249dbed2858e6c2f30e5be7f1f7a709ee2
> 
> Is that a patch for 4.19.75? Or where can I download the patch for 4.19.75?
> 

This patch was included in 4.19. It introduced the message you are
seeing and the commit message explains why you are seeing it.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
