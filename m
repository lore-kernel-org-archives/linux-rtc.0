Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0437938E8B2;
	Mon,  1 Jun 2026 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305262; cv=none; b=UsQe616VXrvREz/zkW22lZEtq+7IgCmBbKlwVMyeexE/8E+Kq6Rdo/sr/LsYW9+B8KWZjOJWOFsusO0EcPZ1V+mySZbXOR2iUlUAOzmRVYt5bCzn+QHcYrs7u04WfPMl9ZGtlHKTAKTTQlgClABWVaDsx9Bzhb9Acz3XdeM/NWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305262; c=relaxed/simple;
	bh=UUmiTipKkk9DzmFJKj37uR0bOtljZyyou0W0KGxbwxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=uxRrE6pQS19C+5cmxbjRePuCd5yvxYRmH0YwowCD6FtU3Awd/IYg6YhkONaOnJnpWXXJ22bxzppzmkJgnPuUVvrucyaygDz+b78Ih8UNRdHan7oL0j/kGjJZRWn1sQ6+KK5ut9vpQaY+bjfJzVvUl1EMCQfDMffpRPmr5f34aUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 1 Jun
 2026 17:14:10 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 1 Jun 2026 17:14:10 +0800
From: Tommy Huang <tommy_huang@aspeedtech.com>
Date: Mon, 1 Jun 2026 17:14:06 +0800
Subject: [PATCH 1/2] dt-bindings: rtc: add ASPEED AST2700 compatible
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260601-ast2700-rtc-v1-1-15d4ca46500a@aspeedtech.com>
References: <20260601-ast2700-rtc-v1-0-15d4ca46500a@aspeedtech.com>
In-Reply-To: <20260601-ast2700-rtc-v1-0-15d4ca46500a@aspeedtech.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, Tommy Huang <tommy_huang@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780305250; l=941;
 i=tommy_huang@aspeedtech.com; s=20260601; h=from:subject:message-id;
 bh=UUmiTipKkk9DzmFJKj37uR0bOtljZyyou0W0KGxbwxs=;
 b=S2E+CuVxKUPTFq2pQv7dQ/0/iNQ1rOOPtB8ZU9f6U0eVWMrT9w0OOm0wpiwFPzrdUIDU9wizE
 WIbbp+tpOKrCmHViQy3Rb512Xyx5DIrrGybwr9Loek522/E8nMYWYCg
X-Developer-Key: i=tommy_huang@aspeedtech.com; a=ed25519;
 pk=/SRU8iPtlyPCtlX7hXjYJhOTpCUdfEZ9pIVVyCQOjLE=

Document the compatible string for the RTC controller found on
ASPEED AST2700 SoCs.

Signed-off-by: Tommy Huang <tommy_huang@aspeedtech.com>
---
 Documentation/devicetree/bindings/rtc/trivial-rtc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
index 722176c831aa..f4d0eed98a08 100644
--- a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
@@ -30,6 +30,8 @@ properties:
       - aspeed,ast2500-rtc
       # ASPEED BMC ast2600 Real-time Clock
       - aspeed,ast2600-rtc
+      # ASPEED BMC ast2700 Real-time Clock
+      - aspeed,ast2700-rtc
       # Conexant Digicolor Real Time Clock Controller
       - cnxt,cx92755-rtc
       # I2C, 32-Bit Binary Counter Watchdog RTC with Trickle Charger and Reset Input/Output

-- 
2.34.1

