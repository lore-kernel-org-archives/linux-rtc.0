Return-Path: <SRS0=IPBj=NS=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504F0C0044C
	for <linux-rtc@archiver.kernel.org>; Wed,  7 Nov 2018 15:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209DA20827
	for <linux-rtc@archiver.kernel.org>; Wed,  7 Nov 2018 15:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209DA20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeKHAjO (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:39:14 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60837 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727775AbeKHAjO (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 7 Nov 2018 19:39:14 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AEAEE224E5; Wed,  7 Nov 2018 16:08:27 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7C22B224DE;
        Wed,  7 Nov 2018 16:08:17 +0100 (CET)
Date:   Wed, 7 Nov 2018 16:08:17 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: cmos: Do not export alarm rtc_ops when we do not
 support alarms
Message-ID: <20181107150817.GB21694@piout.net>
References: <20180904145129.17098-1-hdegoede@redhat.com>
 <20180908143735.GC2598@piout.net>
 <4fd4ff2f-41ad-4695-0c38-64c2bc0b936e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fd4ff2f-41ad-4695-0c38-64c2bc0b936e@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 07/11/2018 13:49:06+0100, Hans de Goede wrote:
> Hi,
> 
> On 08-09-18 16:37, Alexandre Belloni wrote:
> > On 04/09/2018 16:51:29+0200, Hans de Goede wrote:
> > > When there is no IRQ configured for the RTC, the rtc-cmos code does not
> > > support alarms, all alarm rtc_ops fail with -EIO / -EINVAL.
> > > 
> > > The rtc-core expects a rtc driver which does not support rtc alarms to
> > > not have alarm ops at all. Otherwise the wakealarm sysfs attr will read
> > > as empty rather then returning an error, making it impossible for
> > > userspace to find out beforehand if alarms are supported.
> > > 
> > > A system without an IRQ for the RTC before this patch:
> > > [root@localhost ~]# cat /sys/class/rtc/rtc0/wakealarm
> > > [root@localhost ~]#
> > > 
> > > After this patch:
> > > [root@localhost ~]# cat /sys/class/rtc/rtc0/wakealarm
> > > cat: /sys/class/rtc/rtc0/wakealarm: No such file or directory
> > > [root@localhost ~]#
> > > 
> > > This fixes gnome-session + systemd trying to use suspend-then-hibernate,
> > > which causes systemd to abort the suspend when writing the RTC alarm fails.
> > > 
> > > BugLink: https://github.com/systemd/systemd/issues/9988
> > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > ---
> > >   drivers/rtc/rtc-cmos.c | 16 ++++++++++++----
> > >   1 file changed, 12 insertions(+), 4 deletions(-)
> > > 
> > Applied, thanks.
> 
> I'm not seeing this patch in 4.20-rc1 and it is not in
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/log/?h=rtc-next
> 
> So it seems that this one has fallen through the cracks?
> 

Indeed, I don't what happened, I'll queue it as a fix for 4.20. I
checked and this is the only one that was missing.

Thanks for the warning.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
