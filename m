Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3633C433FE
	for <linux-rtc@archiver.kernel.org>; Thu, 13 Oct 2022 21:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiJMVcW (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 13 Oct 2022 17:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJMVcW (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 13 Oct 2022 17:32:22 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C5B170DD6;
        Thu, 13 Oct 2022 14:32:18 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A0370FF803;
        Thu, 13 Oct 2022 21:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1665696735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xN6AVYW/idr9nBOL/NTXcBMNiy0CKnkM7vciDH1lpMc=;
        b=UIrhWRI+256NEuuFmRgvcUiXYaWgWe0Yz7tADl7GjI+51IMI1hy8K0LnEQj1xAcRc6Rocc
        aOjSrC+e5VZKMVXPWTHSYL6aFDxDLu172cCorDp1APajaZUsir9m5AY/qLfaxyRF9OHTam
        uGCXa5qZmll3LcZpy6RoWJd1iM8jU1AoIzL6NfqGEAmP4XRbX9Dg8lhTN+JPhC3UnusJQ5
        UK/SAyjitqMkrJeHW0jVQHRL4nUwtnaJshZ9bH5HRaHAH7ivfaqgkTMa1dnxxUuZVX5Rox
        1PtyLGcnO0pNlVbU3m3n5IpxPe9cIGn5ndMX+ZknrB7WbxOf7iV0JBA0hC7Xtw==
Date:   Thu, 13 Oct 2022 23:32:15 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: k3: Use devm_clk_get_enabled() helper
Message-ID: <166569636075.1226796.778776810864172271.b4-ty@bootlin.com>
References: <601288834ab71c0fddde7eedd8cdb8001254ed7e.1661329498.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <601288834ab71c0fddde7eedd8cdb8001254ed7e.1661329498.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Wed, 24 Aug 2022 10:25:11 +0200, Christophe JAILLET wrote:
> The devm_clk_get_enabled() helper:
>    - calls devm_clk_get()
>    - calls clk_prepare_enable() and registers what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code, the error handling paths and avoid the need of
> a dedicated function used with devm_add_action_or_reset().
> 
> [...]

Applied, thanks!

[1/1] rtc: k3: Use devm_clk_get_enabled() helper
      commit: 8f08553e7e4370cdb8f55f0e3dc4db91ed6a4931

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
