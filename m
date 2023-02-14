Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F15C05027
	for <linux-rtc@archiver.kernel.org>; Tue, 14 Feb 2023 20:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjBNUBK (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 14 Feb 2023 15:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBNUBJ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 14 Feb 2023 15:01:09 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2282D161;
        Tue, 14 Feb 2023 12:01:03 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 130CF1BF208;
        Tue, 14 Feb 2023 20:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1676404862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=msCEMBYUW+ET+AM+rP3myaFEP+xjOZlHNFrZgSaclZ0=;
        b=SOfrLe95ihwFNZ/lLttrf3O4/GmIUyKgjgYJW8rajjNfhT8VbU9DKMIGSj2hSPB/DGc/Ok
        DhC4FRmiPebHyVJ9Yc5krHuQ09f1TpqvzUC15EOvnt36p1C5bJoQNEoVf4XlPQxGIWARwV
        hURbcOlWh/Vin2l6zxsWAnGswDGX+C3THNTUe9MAnpjBGVkC4Slq4/fNCwCiZZDHhzJ/tT
        FLtUWIb6ECB6UI5xZD82DZ1nQx+qp3UoPWRkS8xIALkw4WB8qptnnXrNd/WFDQtkQNcsnB
        bIGv+7/v8Hwdb8quOZko9FXtMrtC3HFK/qi3xSL0jxU1BfQNT0D40/db4RxuLg==
Date:   Tue, 14 Feb 2023 21:01:00 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [REGRESSION] rtc: imx-sc: remove .read_alarm
Message-ID: <Y+vofPf0YVp5Ay65@mail.local>
References: <bbe470eaeeb17624444b37dbe35b0883193e475b.camel@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbe470eaeeb17624444b37dbe35b0883193e475b.camel@toradex.com>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hello,

On 08/02/2023 15:06:28+0000, Marcel Ziswiler wrote:
> Hi Alexandre
> 
> Were you aware that this breaks the sysfs use case? E.g. before we were able to suspend and resume 10 seconds
> later as follows:
> 
> echo +10 > /sys/class/rtc/rtc1/wakealarm; echo mem > /sys/power/state
> 
> Since the removal of .read_alarm in commit 7942121b8ca0 ("rtc: imx-sc: remove .read_alarm") this no longer
> seems to work.
> 
> This seems like a regression or is this not supposed to work?

This seems like a regression and I think it was reported a while ago and
then again just after you. I believe there is something to do that is
smarter than reverting the patch, I need to check.

Regards

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
