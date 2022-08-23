Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29A2C32772
	for <linux-rtc@archiver.kernel.org>; Tue, 23 Aug 2022 20:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbiHWUkn (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 23 Aug 2022 16:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbiHWUkY (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 23 Aug 2022 16:40:24 -0400
X-Greylist: delayed 683 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 Aug 2022 13:29:39 PDT
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFB831B
        for <linux-rtc@vger.kernel.org>; Tue, 23 Aug 2022 13:29:39 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 72E711BF204;
        Tue, 23 Aug 2022 20:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661286578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uN2VYkdfSwi3E9l7InkWZIaCiw/bp4EoACMi+laaycs=;
        b=YZ+IsORwoTRAl34hGnLYQTSRf/1RDZwiGQqHMHRDqXVO69juM500eQ7TQO8aiDDK0GO2F8
        J4V4itVmHUFxEZaGnrwunGUJ4lAKTlYvoEPpeyexTO6BhwSl+rM9D4GYaZMjjl5VHfD2mm
        /uvfZ0HuDL340MPaF1loWZwr51pjES88lLrlJVSEARgRutJVQWOvpkcUIGrqVUP1JS0PNV
        Z/l2mqrvzKDQU1A8qjSJFg7+cIPid1PMdoWGizUIzxx7yFIMchw5BkHcx4cRfn7R9/xsBU
        I+h+NC+YUlIzRsMBs3prwEZsG1ZfqQ+fCz8xUb2frzR8+x6ucC9PJnlgO5jWyA==
Date:   Tue, 23 Aug 2022 22:29:37 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linkmauve@linkmauve.fr
Cc:     j.ne@posteo.net, ash@heyquark.com, r.r.qwertyuiop.r.r@gmail.com
Subject: Re: [PATCH] rtc: gamecube: Always reset HW_SRNPROT after read
Message-ID: <166128648691.2842653.17959514371682917103.b4-ty@bootlin.com>
References: <20220823130702.1046-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823130702.1046-1-linkmauve@linkmauve.fr>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Tue, 23 Aug 2022 15:07:02 +0200, Emmanuel Gil Peyrot wrote:
> This register would fail to be reset if reading the RTC bias failed for
> whichever reason.  This commit reorganises the code around to
> unconditionally write it back to its previous value, unmap it, and
> return the result of regmap_read(), which makes it both simpler and more
> correct in the error case.
> 
> 
> [...]

Applied, thanks!

[1/1] rtc: gamecube: Always reset HW_SRNPROT after read
      commit: 509451ac03eb3afa4c4a32d4c11b1938f08de8e4

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
