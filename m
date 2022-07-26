Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13D8C433EF
	for <linux-rtc@archiver.kernel.org>; Tue, 26 Jul 2022 09:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiGZJWW (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 26 Jul 2022 05:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiGZJWU (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 26 Jul 2022 05:22:20 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8332230F67;
        Tue, 26 Jul 2022 02:22:19 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DA37E4000C;
        Tue, 26 Jul 2022 09:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1658827337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z77u8Y5DYjxcqJrNCOiIhx4nTiZGJ2+SQJQvPZmtZhU=;
        b=fL4CXUHahE2dBDMCOrYfTbZlNMcZoZ99poqZJpRB5LJIRWEb/gawebWItE5st7p+rfaFSX
        4xig1Bmrp4WT9vra/PnoF+vH7e8aMxUQ/4Sv6l3yfcTZRtuug7lCrxbM1PY2MeDSn422Mp
        3BCAupzUw7wYkEAzItWVhwa4bm50j1q18Q56KfHFevyInqVUuEBQf+sweW77hJs5gq/Npi
        phaeSGwWBdx7ykD97EAGDWNE6d6tpCDTDMgF4B8wXZ0aGkaLYojjL7VFgt2/OEp7NLzJ/b
        5O/h3BbTO2C+G5x7RISf/PpNfQB9H5zX8vnuyLdF+OsceaV/no32ygMuK4o1kQ==
Date:   Tue, 26 Jul 2022 11:22:14 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     robh+dt@kernel.org, neelisrinivas18@gmail.com, sgoud@xilinx.com,
        srinivas.neeli@amd.com, srinivas.neeli@xilinx.com,
        michal.simek@xilinx.com, a.zummo@towertech.it,
        krzysztof.kozlowski+dt@linaro.org, shubhraj@xilinx.com
Cc:     git@amd.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, robh@kernel.org, git@xilinx.com,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V10 1/3] dt-bindings: rtc: zynqmp: Add clock information
Message-ID: <165882731655.3141015.12259397630549715904.b4-ty@bootlin.com>
References: <20220626070817.3780977-1-srinivas.neeli@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626070817.3780977-1-srinivas.neeli@xilinx.com>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Sun, 26 Jun 2022 12:38:15 +0530, Srinivas Neeli wrote:
> Added clock information and deprecated calibration support.
> 
> 

Applied, thanks!

[1/3] dt-bindings: rtc: zynqmp: Add clock information
      commit: f69060c14431f476b6993ea92bef77e20437af4e
[2/3] rtc: zynqmp: Updated calibration value
      commit: 85cab027d4e31beb082ec41b71cb8670eeb6fd46
[3/3] rtc: zynqmp: Add calibration set and get support
      commit: 07dcc6f9c76275d6679f28a69e042a2f9dc8f128

Best regards,
-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
