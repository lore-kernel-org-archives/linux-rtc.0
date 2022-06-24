Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6D0CCA483
	for <linux-rtc@archiver.kernel.org>; Fri, 24 Jun 2022 19:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiFXTaq (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 24 Jun 2022 15:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFXTap (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 24 Jun 2022 15:30:45 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAFA51319;
        Fri, 24 Jun 2022 12:30:44 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 56E4BE0004;
        Fri, 24 Jun 2022 19:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656099041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iKFQojvU/Z4xJXXg9m8WeraQpHiDGSwFdVIDjpYzlrc=;
        b=ilHnaDOy/xGvBXeawsdx83QWHi87hzMkk/ldH6oGbb1G6qMetU+xhquoD8ARuso0McG85K
        vqttFHHUWT9KGzdKCvHCjho/uHEqIk7rdK4RYaesERV07h4093L/Z+2uZR4POp35kt25Zr
        BBi8+Fa8sA3TNZ/kLWGoYnZHW/d1uR0aJKu2376HwNZVPAJIJevGWIfjdv5G31jqOT664G
        rpxfK5KYmSp9HzfjTtjTd3YX+Av1aPr3bC0RiIvrmMlNEjrWPg6mAxKXmaJF/FxmrEx6gy
        KoqTb/Ss4A1YkO59RkUFZtpp/uh5w+gth9M+3CYY9T2Rj/V5s26wxOfYbc9r8A==
Date:   Fri, 24 Jun 2022 21:30:38 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     robh+dt@kernel.org, agross@kernel.org, a.zummo@towertech.it,
        krzysztof.kozlowski+dt@linaro.org, bjorn.andersson@linaro.org,
        quic_c_skakit@quicinc.com
Cc:     quic_tsoni@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 0/2] Update the binding documents with latest mail ID
Message-ID: <165609897247.33320.6918087685461996896.b4-ty@bootlin.com>
References: <1655874639-11273-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655874639-11273-1-git-send-email-quic_c_skakit@quicinc.com>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Wed, 22 Jun 2022 10:40:37 +0530, Satya Priya wrote:
> Satya Priya (2):
>   dt-bindings: mfd: qcom-pm8xxx: Update the maintainers section
>   dt-bindings: rtc: qcom-pm8xxx-rtc: Update the maintainers section
> 
> Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml     | 2 +-
>  Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> [...]

Applied, thanks!

[2/2] dt-bindings: rtc: qcom-pm8xxx-rtc: Update the maintainers section
      commit: fa1f8e6ac455b20955f107023916eef946674cb8

Best regards,
-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
