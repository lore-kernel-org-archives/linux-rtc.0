Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793597637;
	b=f8/uP/3Az/3NWwpnDvJ44pjZuPqsnDq7ZSE+9M46FFi4++hrzh7NJ4N2zwJ1w59VRSoe
	 3m9wtKyBwmk/H8Ef+uuZxvq3mzhv+pyanq//VflGbUL/NlqwssDw4B9eNT4TEAge24rya
	 oh3vGeRyM+edLaUW9rE8r5AA9DUGImNucSpOvR5fRRT3yNe9zeqXx9PfovTGbo6XxVkyb
	 Up1DywfryQp0BMSCy5Ws+JRzV47Q1uDkoq5q+29j02v/mVl+ox2beh0M2Oshpm3Bi5hAM
	 X5Z9Pu9De2Zu4i1hmvn+408M44HgF86BrnbWkU+yKqyX/YrMaQl31GoYEU1XaD4Di6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793597637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=fzpgC5Iq6UmNwAV/YxFMKMcnuTBJ158cMfcPvMXN/0k=;
	b=hZk+xa/ejETPkJ07lb8fNlKBjnvLGKCdCQ47pC7EGAebV+Dn5PrZJWbAxhe0z4DO8CA1
	 4Ycg6QfbTsyHncskVxLYxUf9QHZlKd/Ai08AXrnsw7KMInP9ICLSXtBgWuBszd/Azxjjj
	 P5RRWAr+TTyFa6UaVE39DzX2uAFKq3tf/aJWOWIEZO9XP8rP6lS+ggvmGSW+nkpianLpK
	 PwvyeTpS5455XJj/KhjZcRJmkiBwrl8pCO9+VlTzKMiYUa37TLMZU6Ox5vWjK6vL8evex
	 T8fQZqWHqSo/TmZdDaNUgWNqBId2vLgH9ZLpVu29rZcmKVBm5ALN3bFQ2IBrBnG7pIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sAuHaW0v;
	arc=none smtp.remote-ip=74.125.231.134
Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB74606A336
	for <linux-rtc@vger.kernel.org>; Mon,  2 Nov 2026 05:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CB74606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sAuHaW0v
Received: by mail-oo2-f6.google.com with SMTP id 46e09a7af769-8217177c5daso552245a34.0
        for <linux-rtc@vger.kernel.org>; Sun, 01 Nov 2026 21:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793597636; x=1794202436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fzpgC5Iq6UmNwAV/YxFMKMcnuTBJ158cMfcPvMXN/0k=;
        b=sAuHaW0vR6UMGmh9a3LoCfGHR5y2OPt9lNXxAGnagx7UZvkrXmXTFynCOsmmiHLGYq
         GYb9meKDxStFKyJb74iFcxP/aWQQCOg8G3LExXifnWFM3E/7n9VPHXqAtKYCY0i4RTSo
         22nw5djiSJ1MSjDKZG41Dk+Id1piCjeh5PFA135IQ6F6qTtWyzC3gwiU6q1Xoz3lSt5D
         v8ajt5atmPCUw4A+AbfXmQKrMDoTBEdGnXHwCuDXrWT5DHYtckAIPRnRJwyCIks/8rFA
         GC/p9TNJD92kO5t7NKQeiHniFUwdDXG8NsBaLsAGXPTejpHsGwwSDNZ5htqRqyQTNear
         R54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793597636; x=1794202436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fzpgC5Iq6UmNwAV/YxFMKMcnuTBJ158cMfcPvMXN/0k=;
        b=rB09OU3NJLdRncuW/YG046OjlUtIUGqo5tumuiCPZDfXCx+2E1RavfBPokP295nPsw
         XZmJRCKPF2JZAQKhUxsYortHtPCpay1m4Y0dCCk3yoUI+RI6WLNjaRBxOhS7BGtGGTVM
         9d3ytJ/I9E6TZ+YbyCpQeutOH4tCs3LkXczxr81YAPZUpfjCqJsRLZUNS76QLtggXz3R
         z1MDzUynagnqVx5nzMR0e9uF5P2ynb1Mcd/1fLuKgi20QqIJzH8eRD5WyKxD3fGp13sQ
         lnZ9PUuNSuB6iTL1uDtqqp1CmS94ksUgvDlXhzxegLp2J5IxArq2WhWANGscAsGgwMOx
         zRaA==
X-Forwarded-Encrypted: i=1; AKwUvBwMivFSo8vwnBQt0rOfSxB4rNGzn+Cs+m78AS903qv+2fIJA8RIFb9bLMaeQWRkyUPTCNTaLciwFOc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZT22kxaD3Mp5yzXM5eXofFcMQs/mVadng8E+MInCbbQv6vwr1
	xcysj8cSLYa8Z8iigVeKi90gA/Na1S/42SqiOkPfv8yCDTiJUsifpRP+
X-Gm-Gg: AYBFou2DnQtsEacvk3chJyw7mTv51zI1UJzyxUnZ3F1Dxeh/8B0yJLfbifNwAnZYmZB
	Vvngmewnk90x8VxbsQ6pAR91JTCLYDDtxTUgDeq1nIqBUgrWtj+ipZDBEXS2joqaMPLt8JQ5ukl
	VUFtAebH9qzm52++B1fdmLQG6nsC2IFkP8c3bRjrtI4LsbqDXJC8a15+LAkCTHPjSZLiAd8HGp9
	jmEQtRwnHG/jMb8WmXZ5rNpK9VdVBssgh6+Bsu39+BfcZCq0CekSI3k7FICMnREuXP/numCuce4
	xTlSgHjGI9fwMqXe0w5vamXid5qgf/7ipgDDxN/tyEMiEjgTQVyBMZJHNJzUiMDqKFwgxEIg4xY
	7k9AOC8qI0P/IxkFW5aHMxOcbx8O8OX77IN/xB0BoNauZ7TR2jqcJi8NDGGKgZSyL4j00fqOuz9
	Swqc4yJKWestpWZHlDYPxZQnQxLdRZXASMNCWTTgITgMTaTL2M7OVnuWPgogP6dyEj8fEyOunzk
	CGbsnSNvGfmembg6Mo7E/qjxagv3orXB9UbcjKlWYJeyOq/KVtbtpSlMzRG06xy14F7yF1KBbPv
	G/Z8J3SkHp+uoh+5FNk5Fu3l
X-Received: by 2002:a05:6820:1343:b0:70e:3e8e:efdf with SMTP id 006d021491bc7-714f2ae369bmr4807837eaf.89.1793597635764;
        Sun, 01 Nov 2026 21:33:55 -0800 (PST)
Received: from [192.168.18.164] ([2600:8804:5716:d800::f01a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2a818b9sm8321164eaf.1.2026.11.01.21.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 21:33:54 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Sun, 01 Nov 2026 23:33:46 -0600
Subject: [PATCH 1/2] dt-bindings: mfd: mediatek: mt6397: describe the RTC's
 32 kHz output
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-1-9758f38d7053@gmail.com>
References: <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-0-9758f38d7053@gmail.com>
In-Reply-To: <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-0-9758f38d7053@gmail.com>
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Eddie Huang <eddie.huang@mediatek.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rtc@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793597629; l=1164;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=GgCulyiRe8JqnSbuYJBNp+S895kQy071XDUKSDOt2BQ=;
 b=UE2preFnWrcfBUGQB9fs2ZLD6a5Iic6l7jXV2HPJqVzl40mf4eCBFIpiaxRBYwOVNNpkVcGzQ
 NP955JBBzvAD5zz3cEjRiUa5q86u2PzDOoj38Yx6ZzP9oKolUFV8h/8
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

The MT6397 RTC drives its 32 kHz clock out of the PMIC, where boards
use it as the sleep clock of a Wi-Fi/Bluetooth combo chip. The output
is off unless something turns it on.

Let the RTC node provide it as a clock.

Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 055625362951..3bfe1ad60d2d 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -84,6 +84,11 @@ properties:
 
       start-year: true
 
+      "#clock-cells":
+        description:
+          The 32 kHz clock the RTC drives out to other chips.
+        const: 0
+
       nvmem-layout:
         $ref: /schemas/nvmem/layouts/nvmem-layout.yaml
         description:
@@ -694,5 +699,6 @@ examples:
 
         rtc {
             compatible = "mediatek,mt6397-rtc";
+            #clock-cells = <0>;
         };
     };

-- 
2.55.0

