Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2622C07E99
	for <linux-rtc@archiver.kernel.org>; Fri,  9 Jul 2021 23:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5F93613BE
	for <linux-rtc@archiver.kernel.org>; Fri,  9 Jul 2021 23:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhGIXov (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 9 Jul 2021 19:44:51 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:57273 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhGIXov (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 9 Jul 2021 19:44:51 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id BB113240006;
        Fri,  9 Jul 2021 23:42:05 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, iwamatsu@nigauri.org
Subject: Re: [PATCH] rtc: pcf85063: Update the PCF85063A datasheet revision
Date:   Sat, 10 Jul 2021 01:42:05 +0200
Message-Id: <162587410279.1196349.9254321835367986590.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210624120953.2313378-1-festevam@gmail.com>
References: <20210624120953.2313378-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Thu, 24 Jun 2021 09:09:53 -0300, Fabio Estevam wrote:
> After updating the datasheet URL, the PCF85063A  datasheet revision
> has changed.
> 
> Adjust it accordingly.

Applied, thanks!

[1/1] rtc: pcf85063: Update the PCF85063A datasheet revision
      commit: 98c25b8012461f569a4d20bc4a48c489099cf7fd

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
