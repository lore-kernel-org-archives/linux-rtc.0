Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263967;
	b=bbk+EAJ1WzG9eXWeVcdO7qhScBn+GUSYv5+NS3Y6xXIAixRcccfz38pQsU6An7K1nF75
	 /b4eLVt/FsvcXwDqvWcgSmheFeIUooMl8RKruGY4OKBM6c8bKKN3JWhMhJEldieFV6OLg
	 wMx2yxpAwRa0Mo/4ml3uk5bMfh4S8/PBC/f21sDY9lUPGWWMX3FoILFPPAX/mwNoceSBk
	 BYMCxz96oGUbYlANYzns12GobFCv9ACyX+iUexjNVJ4Fp9vqMwPNxnPiW0L0pAF3O4XWC
	 kewtapT9heaCEXZaYq4reGFGt6gdjDfHZbBUZlRGxl2SjL14WDHd+ncOeTsci/ESHlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263967;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=7KQzhLEYfZ3UTyImk4Ei6SfTdbOYpgx2jn/YsGzXETM=;
	b=ehE2FLtA6CKwSwiF5DgjqoEqQEvpKsWAhhSbmnimwQsO/kZosbGFdbBaPa2kCq+p+zVC
	 FZZTt4puJ25U5QGe92UfUNAsaQY0bLMCmI85td7wF7zc38YE9HmmmH3RcMAwlL7GkEC6E
	 MnRjskdGfFbC5qPbMrUsyZfCuM3mheWN8y5TUXedIOGaEbuiJXyM8n99M7JeQBWqMMxD1
	 zM1kY94BOvpqsE9Af9lbI3GygN1t/C7pcydw6Y6A3tBhOYKIIh3Z+kKwN8hEPwW0sV8Em
	 jFc7x6S3tY4sPYphtRT1mXiXDRQaGOl0oqee8H5JFxBHx+5m3Smn8yqKdzUtF3r3WjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=axZRn+iI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E2D606A321;
	Mon,  9 Nov 2026 22:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=axZRn+iI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2061F0089F;
	Mon,  9 Nov 2026 22:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794263967;
	bh=7KQzhLEYfZ3UTyImk4Ei6SfTdbOYpgx2jn/YsGzXETM=;
	h=From:To:Cc:Subject:Date;
	b=axZRn+iIAkcWcRSNoewJyRH5jRKITnRtugGmgXnn9b5g3Zak8iCP1dOn+ckZpOUs8
	 4aWwYB2LVQ3sgu/7jsJWl9L2MBcW41PaQ4PhRgFdaISERLsbBkyXOFa5GWkalsHjBm
	 HTH+DUsHhF1/XvTAHzip5FvedLjIawq+TCeFt4ofzlie6BTK5Ean91G56H/PglF6kh
	 zFtEt1ZZH/VIUjy0GQiIblIYIN4OpP6Drqe5i+kB0kt/anyrGvLETbmrW+doLA5wG9
	 HVNY0dSFGYs769jK0EW4ASzmfkMf73bwrBTTjzyJjcQnrUOe7zMn12fi7tEdw8WcHJ
	 JMTUuIiQJw6ng==
From: Thorsten Blum <blum@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <blum@kernel.org>
Subject: [PATCH 1/5] rtc: gamecube: Propagate address translation error
Date: Mon,  9 Nov 2026 23:39:03 +0100
Message-ID: <20261109223902.84918-6-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=793; i=blum@kernel.org; h=from:subject; bh=E1SEg9MyBpLtn01dLDiAnt1Z0aEgdAcMGkMbgVQqDzw=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmfvNtO8/od5u6eab10qtcFlXsqazM3zjNrv/d6/xL+v v2O1gf8OkpZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAiM58xMvwSWx1fn3Lrr1uf tWLP8vWOFmFntla7VyyVT326UizhmhQjw8MpW9c0GC05q5S01MJHcrnQDp+c7a6TfR0cpzh2qSj 8YAAA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

If of_address_to_resource() fails, propagate its error code instead of
returning -1 from gamecube_rtc_read_offset_from_sram().

Fixes: 86559400b3ef ("rtc: gamecube: Add a RTC driver for the GameCube, Wii and Wii U")
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/rtc/rtc-gamecube.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-gamecube.c b/drivers/rtc/rtc-gamecube.c
index 3fd562d3526a..0299f27106c0 100644
--- a/drivers/rtc/rtc-gamecube.c
+++ b/drivers/rtc/rtc-gamecube.c
@@ -238,7 +238,7 @@ static int gamecube_rtc_read_offset_from_sram(struct priv *d)
 	of_node_put(np);
 	if (ret) {
 		pr_err("no io memory range found\n");
-		return -1;
+		return ret;
 	}
 
 	hw_srnprot = ioremap(res.start, resource_size(&res));
