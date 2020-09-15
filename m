Return-Path: <SRS0=5D1E=CY=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35750C43461
	for <linux-rtc@archiver.kernel.org>; Tue, 15 Sep 2020 10:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E051121D7D
	for <linux-rtc@archiver.kernel.org>; Tue, 15 Sep 2020 10:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgIOK2V (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 15 Sep 2020 06:28:21 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:59625 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgIOK2U (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 15 Sep 2020 06:28:20 -0400
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr [90.65.88.165])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id D872910000A;
        Tue, 15 Sep 2020 10:28:17 +0000 (UTC)
Date:   Tue, 15 Sep 2020 12:28:17 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Biwen Li <biwen.li@oss.nxp.com>
Cc:     leoyang.li@nxp.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiafei.pan@nxp.com,
        Biwen Li <biwen.li@nxp.com>
Subject: Re: rtc: fsl-ftm-alarm: add shutdown interface
Message-ID: <20200915102817.GL4230@piout.net>
References: <20200330122616.24044-1-biwen.li@oss.nxp.com>
 <20200330164400.GE846876@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330164400.GE846876@piout.net>
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi,

On 30/03/2020 18:44:01+0200, Alexandre Belloni wrote:
> On 30/03/2020 20:26:16+0800, Biwen Li wrote:
> > From: Biwen Li <biwen.li@nxp.com>
> > 
> > Add shutdown interface
> > 
> > Signed-off-by: Biwen Li <biwen.li@nxp.com>
> > ---
> >  drivers/rtc/rtc-fsl-ftm-alarm.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/rtc/rtc-fsl-ftm-alarm.c b/drivers/rtc/rtc-fsl-ftm-alarm.c
> > index d7fa6c16f47b..118a775e8316 100644
> > --- a/drivers/rtc/rtc-fsl-ftm-alarm.c
> > +++ b/drivers/rtc/rtc-fsl-ftm-alarm.c
> > @@ -307,6 +307,15 @@ static int ftm_rtc_probe(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > +static void ftm_rtc_shutdown(struct platform_device *pdev)
> > +{
> > +	struct ftm_rtc *rtc = platform_get_drvdata(pdev);
> > +
> > +	ftm_irq_acknowledge(rtc);
> > +	ftm_irq_disable(rtc);
> > +	ftm_clean_alarm(rtc);
> 
> If the alarm is able to start the platform, then you probably don't want
> to disable the alarm on shutdown.
> 

I realise you never replied to that question. Is that patch still of
interest?

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
