Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92FEC433F5
	for <linux-rtc@archiver.kernel.org>; Thu, 19 May 2022 10:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbiESKGp (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 19 May 2022 06:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiESKGm (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 19 May 2022 06:06:42 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738FF3A5D5;
        Thu, 19 May 2022 03:06:37 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2D6621C0008;
        Thu, 19 May 2022 10:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652954796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oDc/l+ZvXyh/h4RLRg/o7k1scruepHlpxflzm71xEPg=;
        b=hN7i8a5GqerC9XaBkUR4ixwCNgLNDgbfrG0m4QGCyuhvkd3n4ycYZeieFwKMC7Q7wMtMgq
        8HvbQQbfDjrrgpOc9Xygd004j/QjbLN1OuXzuUqtwpVB6A6CAroYlasTJ2jEyRwVcaQhaU
        B+k48tIhxQmUIlAscrB3n2HmanJXdnVilPuPFD/pCsZmb0SnvFwlzi5jZ5wuyinxsAlYpW
        vK/rK5ePfFZfE9glmi1RHwHM8/bos8vmf7/7Ovmkzx7DJ3YkSBmv+KY6hxcj/wSs28Q6Vc
        3A7vUJrvqExQLEmTAB2yUcrttt1JN5+sSRl7FkVzKDSuBGWLX8HFoSX6Y8qfbg==
Date:   Thu, 19 May 2022 12:06:35 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     a.zummo@towertech.it, sean.wang@mediatek.com, lee.jones@linaro.org,
        eddie.huang@mediatek.com
Subject: Re: [PATCH] rtc: mt6397: check return value after calling
 platform_get_resource()
Message-ID: <165295476623.538132.4203762589258593822.b4-ty@bootlin.com>
References: <20220505125043.1594771-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505125043.1594771-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Thu, 5 May 2022 20:50:43 +0800, Yang Yingliang wrote:
> It will cause null-ptr-deref if platform_get_resource() returns NULL,
> we need check the return value.
> 
> 

Applied, thanks!

[1/1] rtc: mt6397: check return value after calling platform_get_resource()
      commit: d3b43eb505bffb8e4cdf6800c15660c001553fe6

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
