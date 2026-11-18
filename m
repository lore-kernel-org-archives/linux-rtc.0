Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=49.212.47.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794965446;
	b=HGb+WGmuFjoDS2B4fl/3DXbs5m2OLCIolXKgFW0Q9Ly2/uWAu20DVMUjOv3q12o/4J1a
	 GGhQEhDEUQM/Qa8y7ftqcAXGhtUzpP3DKWJz5LrTOOWhgPXEst4fZv2yMGqnphGC+/CIo
	 sQMmmvJ+1+BDLapAWC+hDjya7DlU71MsVS08P9iibVjBoyKaDixBq+Hg+lcOvKXYG5Lps
	 eQLhTX6sL+0xLHHrPpTBGPnJL5GbwYxJ73k3lkw5eCHabcRn0okhkLcfJVKnnWD8wcNNZ
	 YHEKfvDfWoiLM+p/MvlAvqSvn53ayfPukquHvC/R7Xu4zwCqUS7f05bEO+jLlNxe6xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794965446;
	h=DMARC-Filter:Received:DKIM-Filter:To:From:X-Ip:X-Ip-source:
	 Precedence:List-Unsubscribe:List-Unsubscribe-Post:Subject:
	 Mime-Version:Content-Type:Content-Transfer-Encoding:X-MagazineId:
	 X-uId:X-Sender:X-Url:Message-Id:Date;
	bh=sujvEF8pQRywcRUm6psw9C2ytbWDQ3jL7t/ThwskqTE=;
	b=tcllyX3HCFEVwaPR3J6OS63M07tmnpQPXT/J6veosp6j2RxwfyorFtwGo2VZf9RQ8ZCb
	 8I7rWBSE7VmDkgEz3BE8KGpGeRXuZghTX2xF8/q14WqrbUBSzP3nIzCHcrcNk6qhG2T4o
	 qJfuLJyQ5QMaPpVI55uAo/TevBLVoy9RJBskYZ999Rvfu6ap3/FCNfPebYnds2DhxT2f4
	 SsDgBOh5LKUW6y3ns7KDtsKwDv0qAHT/ILes8UQsFvjuhPcIMOZEF7BuTK6SQHpW4RxFa
	 E35FrM1C04R00aWTuIJGMNtrlYrI6Yhgo10PiTuejaeVnnlVmKuU30+uV84tbtY/GGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ai-webseminar.jp;
	spf=pass smtp.mailfrom=magerr.combzmail.jp;
	arc=none smtp.remote-ip=49.212.47.36
Received: from r9114.ps.combzmail.jp (r9114.ps.combzmail.jp [49.212.47.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6740606A31C
	for <linux-rtc@vger.kernel.org>; Wed, 18 Nov 2026 01:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6740606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ai-webseminar.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=magerr.combzmail.jp
Received: by r9114.ps.combzmail.jp (Postfix, from userid 99)
	id 99BA4307552; Wed, 18 Nov 2026 10:29:41 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 r9114.ps.combzmail.jp 99BA4307552
To: linux-rtc@vger.kernel.org
From: =?ISO-2022-JP?B?GyRCTmtMWhsoQg==?= =?ISO-2022-JP?B?GyRCOkwhQxsoQg==?=
 AI =?ISO-2022-JP?B?GyRCJSghPCU4JSclcyVIM2hNUSU7JV8lSiE8O3ZMMzZJGyhC?= <info@ai-webseminar.jp>
X-Ip: 612009428419380
X-Ip-source: k85gj7ft48dnsa51u0p6gd
Precedence: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Subject: =?ISO-2022-JP?B?GyRCOkc2LyRORixHPiRIP008aiRyISMbKEI=?=
 =?ISO-2022-JP?B?Q2xhdWRlGyRCJTslXyVKITwbKEI=?=
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-MagazineId: ft51
X-uId: 6764325639486067714159411008
X-Sender: CombzMailSender
X-Url: http://www.combzmail.jp/
Message-Id: <20261118013006.99BA4307552@r9114.ps.combzmail.jp>
Date: Wed, 18 Nov 2026 10:29:41 +0900 (JST)

　
　
　自分の間違いを見つけて「自己進化」する
　
　最強の「頭脳」と「人手」を手に入れたい
　経営層の方向けに
　
　2,000名超に講演してきたAIの専門家が
　驚きと手触り感のある実演デモで解説します。
　
　 ・自己進化するAIとは
　 ・受信メールから業務を自律実行
　 ・競合分析、SWOT分析から戦略立案
　 ・決算書から経営ダッシュボード生成
　 ・AI導入につかえる助成金情報
　
　
　 ＼ 明日から使えるプロンプトを進呈 ／
───────────────────────
　
　　　　−人手不足での倒産を防ぐ−
　　　　 　　Claude Code活用
　　   最強の頭脳と人手を手に入れる
　
　　 https://ai-webseminar.jp/claude/
　
　日程：11月26日（木）12:00-13:00　残り9席
　
　備考：Zoom開催／無料／60分／1社2名まで
　
───────────────────────
　
　人手不足による倒産が過去最多を更新する今。

　自らの間違いや非効率を見つけて「自己進化」し
　業務を動かしてくれる優秀な「人手」を逃す手はありません。
　
　そして、その人手をどう活かすかを決めるには
　経営者やリーダー層の視座が欠かせません。
　
　事前知識は不要です。
　非エンジニアの方にもイメージしやすい言葉でお話しします。
　
　今後の経営を変える60分。
　その驚きの実力を、画面越しにぜひ体感してください。
　
　
─…─…─…─…─…─…─…─…─…─…─…─…─…─…─…─…─
　[窓 口] AIエージェント活用セミナー事務局（イーアシスト内）
　[電 話] 0120-889-859
　[住 所] 大阪市中央区日本橋1-17-17 604号室

------------------------------------------------------------------

　メール受信を希望されない方は大変お手数ですが
　以下より配信解除をお願いいたします。
　※解除までに数日お時間をいただく場合がございます。
　https://ai-webseminar.jp/teishi/
─…─…─…─…─…─…─…─…─…─…─…─…─…─…─…─…─
