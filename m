Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794609214;
	b=i2H7mwS1p7sa34lKw1gp0mvonhmk2tz3XcoEdJ8cLhYvrmxnA6kJyhENPiDju1n2BibI
	 gHRErpWglcdQbkktnANUpdJwK0X2YWpieQaO9nyBK/3hjcAQ5mjMny9sVP7Vnb6xLMIF/
	 UvGNxZyeDdxfVyLChrtfqGYzvjMvNgbip+xKZzWA7S3/dkWvT68b4XyHExBFEsGcvklqE
	 3YzVq8x09L8g6BsawDdwDkYwuTaHG4sPq47yvv1FmP1j1mo0sso43k+kjkLTaLLu5+Po7
	 VQk/uutCioOdR1813Df/KlXMthxfEvunG++ya6cfKJmRs9xH7XtwCCMbrJ6MoKRJGSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609214;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=TOlclL4YMcO1403e1qiCF3GU/nuLdoHldjlrv0LH3a8=;
	b=3dSc/hKeQJt0YGZiJr0PBmtIhfYw9JejBoNHp6F5jee1qRhtd+QXP0lowRqBa4xfMbQL
	 psPo+W1jktEJb6imM+TijXt0OuyGtMfxi4R9/UDih94A3IVDrHtF+ugPRoxNsd3PH5lNr
	 db/K6wu47YUBNyl1pnvg+J3c3ddWIdm8Iy//JWwXj2Lna5QPUInqmUZpaFhDkdyBx5hna
	 6dTeq950BwgC1GMzdyhaz4EUQS3YHiJBixqklLi61zq5a4Dyi3W0JIvbFh+d/P8GOjiTO
	 j29sEwDU6ZYiwEelssd46byqIrpQRlaqexDdMX6HBmlRFLP7evWlJQm0c/av70fGedA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NkfHNVQ2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87150606A8A4;
	Fri, 13 Nov 2026 22:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NkfHNVQ2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794609214;
	b=X7Nk/tZ7GonNx2KBw/8y4OaHJ5i7FCx8F7Vj1hsZFRhpxGtoYW59w76uQgBX493EgOCd
	 mD87NDzx6MTRA9HakTlPL0MpVUgtKBofSunRxLAkVv4BVHyryv3IAFgmQ2aiauMZjMmqK
	 B1oAgi/gO0Jn5zoQkb5hxY/EUVZ3J/H/lAcwYFr/dHkG5tcr0yRCTrlAyEM1Nj2o+sjiL
	 GRADLAPwSr70itdqlRIQilL0GFehQ1QnDQefOA+0FdMsGuHh7baLdd5fGisnmsorRd/AR
	 +lBLlGDJP/nJXSYptVvEr2aCOOfOtUyz9l9Vpwf08x5O1AL+WYEsvrdQkfzSSkRQCBA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794609214;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=TOlclL4YMcO1403e1qiCF3GU/nuLdoHldjlrv0LH3a8=;
	b=d0GE6jupYk62y2sKYS/5FpGJDkn42D0xd7bDk5SFe65Vv4ghP6InG7lhVSEBgjaaVVaK
	 /1vcSRm5xlZvFjRi5dzKWUuUYOYUqn1DA15py6vxIxD+fm+mfL85lHj7hP4+gH7Rj32rG
	 oUq6qz/I8ffNvPbgiQyYImr94+tbK4tigRXWAM3aDCJXfN3EuiPIsUzSzM2AlEDc6TqRg
	 W1/dMSKvKdcl2vVmpteLEVFzGzip4NwKtomYPir7B48thsIMPAh/mCb9aHkgbMAslElBO
	 nr4VKmdPJUvInZc2GBIs90JF+tPCcxbqPkjUMCuj77yUmgRC3rqg3xFPPIoyovmlxIg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3286A1F000C5;
	Fri, 13 Nov 2026 22:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609214;
	bh=TOlclL4YMcO1403e1qiCF3GU/nuLdoHldjlrv0LH3a8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=NkfHNVQ2TMvbmMXE6fHwvBl9xcmpq9ky0p9rvXKU8tCScCglkZl3L/h/IS23zeIgj
	 4WlapfQCcG63cdRxJkgHoUa5ta94XtV1YB0VFKL9QwsIp5QJ+dERlhTaFOxLamvr7G
	 +6DTAQpTDl4xbvdR9Ts/X3fBIEtNJRg6CVdQDuGSuuKUHOFj6sbeUk8caDwbC/65Cd
	 JGsdB/alXmyDqQpNl5OphsA9VvGmaJ+qZiAcBKqCQkRTOvNC6MdY6FWiI8N+N6Hhhb
	 J10jihh2o7g0l0tzyewbVoYhZEyQh9DqYYNC6DHFWtEhFNQxipo7I7UdmqmJz9D0Vz
	 S2OJKXYUweEzg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B1FFB49B5C;
	Fri, 13 Nov 2026 22:33:32 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Sat, 14 Nov 2026 06:33:28 +0800
Subject: [PATCH 02/19] dt-bindings: riscv: cpus: add the XuanTie C907
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
Message-Id: <20261114-v861-v1-2-eb71ec3ee523@iscas.ac.cn>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
In-Reply-To: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Han Gao <gaohan@iscas.ac.cn>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Maxime Ripard <mripard@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>
Cc: Han Gao <rabenda.cn@gmail.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 devicetree@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
 linux-gpio@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794609209; l=986;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=Cm+aoOEvEdfEXFBW81kE8hGffN29ckzRUH816nQCB7k=;
 b=mWoK/d3s7E1yljsgEDG5AOvjeGoZNBwoSoucC5cXcDHH1Ezvl8ge/m6Rc2ZMX+fXR9/JUk6Cd
 sgDp+kyX4ikACJQQaTT68CWvbDPAa7lgh8Bv3nSSLDGn7sHbxhQnbqQ
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn
Content-Transfer-Encoding: 7bit

From: Han Gao <gaohan@iscas.ac.cn>

Add the XuanTie C907, used in the Allwinner V861.

XuanTie is a brand of C-SKY Microsystems [1], whose JEP106 ID 0x5b7 [2]
is what the C907 reports in mvendorid, so use the csky prefix rather
than thead.

[1] https://www.xrvm.com/declaration
[2] https://www.jedec.org/standards-documents/docs/jep-106ab

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 0da219ae6769..bdb119ab8ee0 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -48,6 +48,7 @@ properties:
               - amd,mbv64
               - andestech,ax45mp
               - canaan,k210
+              - csky,c907
               - nuclei,ux900
               - sifive,bullet0
               - sifive,e5

-- 
2.55.0


