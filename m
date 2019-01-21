Return-Path: <SRS0=tSN2=P5=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B79C65C17
	for <linux-rtc@archiver.kernel.org>; Mon, 21 Jan 2019 10:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C32A2089F
	for <linux-rtc@archiver.kernel.org>; Mon, 21 Jan 2019 10:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548064816;
	bh=0bGFfZVE62ixRN9NDfwWeMWEPj2l21w1BEYJ54rnCPk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=z9P2K0jmBh+zWjOS2T4JBOxUxAmXO4Eg66QSfz3AYqa5aEthRMkXhnawEQFR3vmDZ
	 f7T5lmbcfCEyy6q0u/7h9sOJJD1H9cS2ye55SV7L07NoGln4pvKgacTwEkRJdX5VPL
	 CpFpYJ8pipWc0YHel3dnM7ejeVHBUrnLrjUp8+F8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbfAUKAP (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:00:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:45004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfAUKAO (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 21 Jan 2019 05:00:14 -0500
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98E1320663;
        Mon, 21 Jan 2019 10:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548064812;
        bh=0bGFfZVE62ixRN9NDfwWeMWEPj2l21w1BEYJ54rnCPk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pGAFvSp42jVuCFsQ+/A/pF976ZKWvPQfO6V5kP5GB9R9mz3aE4r/jIwUHPDzXWDcq
         wlnS78BmWrDLbKJyCDr1WnEtFqYLuk2Hx6HzdPVz3lR9PYICj9zJYYJAwv1Ah4f+Ce
         dCaG8a8yOy+1XRnsz5GIKVIsKZJb0a7spmJDJMRk=
Received: by mail-lf1-f43.google.com with SMTP id u18so15011039lff.10;
        Mon, 21 Jan 2019 02:00:12 -0800 (PST)
X-Gm-Message-State: AJcUukcCd9ABH+IL558nvJAG5V9pBT8MhJObpH9oAJM7jOrKb3yRvG8D
        zwlTV/wxD4jhtAukzrajHhLYb5mRM4Ad8oC3oaQ=
X-Google-Smtp-Source: ALg8bN4zzr5zaJEpC/GEb/WCKV4hqCxuHYJtwf7HHOxHJTrT9wXgS8YsDqSJf7nS7wA0LyGADwHs56PC0cLWyayFk78=
X-Received: by 2002:a19:2d16:: with SMTP id k22mr17367263lfj.12.1548064810647;
 Mon, 21 Jan 2019 02:00:10 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190118132826eucas1p2b158579e05c57a4e73edfaf376b0108c@eucas1p2.samsung.com>
 <20190118132754.15660-1-m.szyprowski@samsung.com> <20190119201702.GA3590@kozik-lap>
 <a2bbd0c1-826c-f55a-5c33-488794cf8574@samsung.com>
In-Reply-To: <a2bbd0c1-826c-f55a-5c33-488794cf8574@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 21 Jan 2019 10:59:59 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcgdubsBuRuDeU6MBCPv7NCoC70bAMBi==uB4gVYym-cg@mail.gmail.com>
Message-ID: <CAJKOXPcgdubsBuRuDeU6MBCPv7NCoC70bAMBi==uB4gVYym-cg@mail.gmail.com>
Subject: Re: [PATCH] rtc: s3c: Rewrite clock handling
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-rtc@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Mon, 21 Jan 2019 at 09:39, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Hi Krzysztof,
>
> On 2019-01-19 21:17, Krzysztof Kozlowski wrote:
> > On Fri, Jan 18, 2019 at 02:27:54PM +0100, Marek Szyprowski wrote:
> >> s3c_rtc_enable/disable_clk() functions were designed to be called multiple
> >> times without reference counting, because they were initially used in
> > s/used/used only/
> > (if I understand correctly the logic)
> >
> >> alarm setting/clearing functions, which can be called both when alarm is
> >> already set or not. Later however, calls to those functions have been added to
> >> other places in the driver - like time and /proc reading callbacks, what
> >> results in broken alarm if any of such events happens after the alarm has
> >> been set. Fix this by simplifying s3c_rtc_enable/disable_clk() functions
> >> to rely on proper reference counting in clock core and move alarm enable
> >> counter to s3c_rtc_setaie() function.
> >>
> >> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> ---
> >>  drivers/rtc/rtc-s3c.c | 67 ++++++++++++++++++-------------------------
> >>  1 file changed, 28 insertions(+), 39 deletions(-)
> >>
> >> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> >> index 04c68178c42d..e682977b4f6e 100644
> >> --- a/drivers/rtc/rtc-s3c.c
> >> +++ b/drivers/rtc/rtc-s3c.c
> >> @@ -39,7 +39,7 @@ struct s3c_rtc {
> >>      void __iomem *base;
> >>      struct clk *rtc_clk;
> >>      struct clk *rtc_src_clk;
> >> -    bool clk_disabled;
> >> +    bool alarm_enabled;
> >>
> >>      const struct s3c_rtc_data *data;
> >>
> >> @@ -47,7 +47,7 @@ struct s3c_rtc {
> >>      int irq_tick;
> >>
> >>      spinlock_t pie_lock;
> >> -    spinlock_t alarm_clk_lock;
> >> +    spinlock_t alarm_lock;
> > Maybe add short comment that it protects only "alarm_enabled" property?
> >
> >>
> >>      int ticnt_save;
> >>      int ticnt_en_save;
> >> @@ -70,44 +70,28 @@ struct s3c_rtc_data {
> >>
> >>  static int s3c_rtc_enable_clk(struct s3c_rtc *info)
> >>  {
> >> -    unsigned long irq_flags;
> >>      int ret = 0;
> >>
> >> -    spin_lock_irqsave(&info->alarm_clk_lock, irq_flags);
> >> +    ret = clk_enable(info->rtc_clk);
> >> +    if (ret)
> >> +            goto out;
> > The out label is now empty so just "return ret". It is easier to read -
> > no need to jump anywhere to see the simple return.
> >
> >>
> >> -    if (info->clk_disabled) {
> >> -            ret = clk_enable(info->rtc_clk);
> >> -            if (ret)
> >> +    if (info->data->needs_src_clk) {
> >> +            ret = clk_enable(info->rtc_src_clk);
> >> +            if (ret) {
> >> +                    clk_disable(info->rtc_clk);
> >>                      goto out;
> >> -
> >> -            if (info->data->needs_src_clk) {
> >> -                    ret = clk_enable(info->rtc_src_clk);
> >> -                    if (ret) {
> >> -                            clk_disable(info->rtc_clk);
> >> -                            goto out;
> >> -                    }
> >>              }
> >> -            info->clk_disabled = false;
> >>      }
> >> -
> >>  out:
> >> -    spin_unlock_irqrestore(&info->alarm_clk_lock, irq_flags);
> >> -
> >>      return ret;
> >>  }
> >>
> >>  static void s3c_rtc_disable_clk(struct s3c_rtc *info)
> >>  {
> >> -    unsigned long irq_flags;
> >> -
> >> -    spin_lock_irqsave(&info->alarm_clk_lock, irq_flags);
> >> -    if (!info->clk_disabled) {
> >> -            if (info->data->needs_src_clk)
> >> -                    clk_disable(info->rtc_src_clk);
> >> -            clk_disable(info->rtc_clk);
> >> -            info->clk_disabled = true;
> >> -    }
> >> -    spin_unlock_irqrestore(&info->alarm_clk_lock, irq_flags);
> >> +    if (info->data->needs_src_clk)
> >> +            clk_disable(info->rtc_src_clk);
> >> +    clk_disable(info->rtc_clk);
> >>  }
> >>
> >>  /* IRQ Handlers */
> >> @@ -135,6 +119,7 @@ static irqreturn_t s3c_rtc_alarmirq(int irq, void *id)
> >>  static int s3c_rtc_setaie(struct device *dev, unsigned int enabled)
> >>  {
> >>      struct s3c_rtc *info = dev_get_drvdata(dev);
> >> +    unsigned long flags;
> >>      unsigned int tmp;
> >>      int ret;
> >>
> >> @@ -151,17 +136,19 @@ static int s3c_rtc_setaie(struct device *dev, unsigned int enabled)
> >>
> >>      writeb(tmp, info->base + S3C2410_RTCALM);
> >>
> >> -    s3c_rtc_disable_clk(info);
> >> +    spin_lock_irqsave(&info->alarm_lock, flags);
> >>
> >> -    if (enabled) {
> >> -            ret = s3c_rtc_enable_clk(info);
> >> -            if (ret)
> >> -                    return ret;
> >> -    } else {
> >> +    if (info->alarm_enabled && !enabled)
> >>              s3c_rtc_disable_clk(info);
> >> -    }
> >> +    else if (!info->alarm_enabled && enabled)
> >> +            ret = s3c_rtc_enable_clk(info);
> >>
> >> -    return 0;
> >> +    info->alarm_enabled = enabled;
> >> +    spin_unlock_irqrestore(&info->alarm_lock, flags);
> >> +
> >> +    s3c_rtc_disable_clk(info);
> >> +
> >> +    return ret;
> >>  }
> >>
> >>  /* Set RTC frequency */
> >> @@ -357,10 +344,10 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
> >>
> >>      writeb(alrm_en, info->base + S3C2410_RTCALM);
> >>
> >> -    s3c_rtc_disable_clk(info);
> >> -
> >>      s3c_rtc_setaie(dev, alrm->enabled);
> >>
> >> +    s3c_rtc_disable_clk(info);
> > I do not understand this change - why do you have to move the disable
> > clk? The s3c_rtc_setaie() takes care about clock enabling/disabling for
> > the time of accessing registers.
>
> This was micro optimization, s3c_rtc_setaie() increases clock enable
> count, so by changing the call order we can avoid one disable/enable
> sequence.

OK.

> >> +
> >>      return 0;
> >>  }
> >>
> >> @@ -491,7 +478,7 @@ static int s3c_rtc_probe(struct platform_device *pdev)
> >>              return -EINVAL;
> >>      }
> >>      spin_lock_init(&info->pie_lock);
> >> -    spin_lock_init(&info->alarm_clk_lock);
> >> +    spin_lock_init(&info->alarm_lock);
> >>
> >>      platform_set_drvdata(pdev, info);
> >>
> >> @@ -591,6 +578,8 @@ static int s3c_rtc_probe(struct platform_device *pdev)
> >>
> >>      s3c_rtc_setfreq(info, 1);
> >>
> >> +    s3c_rtc_disable_clk(info);
> > I cannot find the reason why this is related to this particular change.
> > I mean, it looks reasonable because previously the clock looked like it
> > was enabled all the time... but maybe this should be separate pach?
>
> It wasn't enabled all the time, because the call to s3c_rtc_setfreq()
> disabled it (remember there was no clock enable reference counting!).
> Now once we have enable/disable reference counting, we need to keep them
> balanced.

I get it, thanks!

Best regards,
Krzysztof
